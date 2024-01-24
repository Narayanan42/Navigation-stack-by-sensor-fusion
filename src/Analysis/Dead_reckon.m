data_imu = readtable('imu.csv');
data_gps = readtable('gps.csv');

mx = data_imu.field_MagField_magnetic_field_x;  
my = data_imu.field_MagField_magnetic_field_y;
mz = data_imu.field_MagField_magnetic_field_y;

qw = data_imu.field_IMU_orientation_w;
qx = data_imu.field_IMU_orientation_x;
qy = data_imu.field_IMU_orientation_y;
qz = data_imu.field_IMU_orientation_z;

gz = data_imu.field_IMU_angular_velocity_z;
gz = highpass(gz,0.01,2);

gps_e = data_gps.field_utm_easting;
gps_n = data_gps.field_utm_northing;

gps_e = (gps_e - min(gps_e)) / 100;
gps_n = (gps_n - min(gps_n)) / 100;

accel_x = data_imu.field_IMU_linear_acceleration_x;  
accel_y = data_imu.field_IMU_linear_acceleration_y;  
accel_x = accel_x - 0.2 ;
accel_y = accel_y - 0.2;

time  = data_imu.x_time;
time = time - min(time);

R1 = [0.9958 -0.0915; 0.0915 0.9958];
sigma = 0.3278;

mx_hi = mx.'; 
my_hi = my.';

v_hi = R1 * [mx_hi; my_hi];   

mx_si = v_hi(1,:);  
my_si = sigma*v_hi(2,:); 

q = quaternion(qw, qx, qy, qz);
R3 = quat2rotm(q);

mx_n = zeros(size(mx_si));
my_n = zeros(size(my_si)); 
mz_n = zeros(size(mz));

for i = 1:length(mx_si)
    mx_n(i) = R3(1,1)*mx_si(i) + R3(1,2)*my_si(i) + R3(1,3)*mz(i);
    my_n(i) = R3(2,1)*mx_si(i) + R3(2,2)*my_si(i) + R3(2,3)*mz(i); 
    mz_n(i) = R3(3,1)*mx_si(i) + R3(3,2)*my_si(i) + R3(3,3)*mz(i);
end

yaw_mag = atan2(mx_n, my_n); 
yaw_mag = yaw_mag - 0.83 + 0.1654; 
time_mag = time;
i=1;
while i <= length(yaw_mag)
    if abs(yaw_mag(i)) > 0.7
        yaw_mag(i) = [];
        time_mag(i) = []; 
    end
    i=i+1;
end


yaw_gyro = cumtrapz(gz); 
yaw_gyro = (yaw_gyro/10^3);

fs = 100; 
fc = 0.7;  
nyq = fs/2;
Wn = fc/nyq;
[b,a] = butter(4,Wn,'low');
yaw_lpf = filter(b,a,yaw_mag);

fs = 100; 
fc = 0.7;  
nyq = fs/2;
Wn = fc/nyq;
[b,a] = butter(4,Wn,'high');
yaw_hpf = filter(b,a,yaw_gyro);


yaw_cf = [];
alpha = 0.98;
N = min([length(yaw_mag) length(yaw_gyro)]);
for i = 1:N
   yaw_cf(i) = alpha * yaw_lpf(i) + (1 - alpha) * yaw_hpf(i);
end

yaw = yaw_cf;

vel_x = cumtrapz(time, accel_x);
vel_x = vel_x / 10^9;

for i=1:length(yaw)
    vel_e(i) = vel_x(i) * cos(yaw(i)*10);
    vel_n(i) = vel_x(i) * sin(yaw(i)*10);
end

pos_e = cumtrapz(vel_e);
pos_n = cumtrapz(vel_n);

pos_e = pos_e *10^-4;
pos_n = pos_n * 10^-4;

figure;
subplot(2,1,1);
plot(pos_e, pos_n);
title('Estimated Trajectory');
xlabel = 'easting';
ylabel = 'northign';
hold on;
grid on;

subplot(2,1,2); 
plot(gps_e, gps_n);
title('Actual GPS');
xlabel = 'easting';
ylabel = 'northing';
grid on;

