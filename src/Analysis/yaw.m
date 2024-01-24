% Read in CSV data 
data = readtable('imu.csv');

mx = data.field_MagField_magnetic_field_x;  
my = data.field_MagField_magnetic_field_y;
mz = data.field_MagField_magnetic_field_z;
qw = data.field_IMU_orientation_w;
qx = data.field_IMU_orientation_x;
qy = data.field_IMU_orientation_y;
qz = data.field_IMU_orientation_z;
gz = data.field_IMU_angular_velocity_z;
time  = data.x_time;
time = time - min(time);
raw_gz = gz;

R1 = [0.9958 -0.0915; 0.0915 0.9958];
% R1 = [0.75 -0.1443; -0.1443 0.9167];
sigma = 0.3278;

mx_hi = mx.'; 
my_hi = my.';

v_hi = R1 * [mx_hi; my_hi];   


mx_si = -v_hi(1,:);  
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
yaw_gyro = cumtrapz(gz); 
yaw_gyro = (yaw_gyro/10^3);

fs = 100; 
fc = 0.7;  
nyq = fs/2;
Wn = fc/nyq;
[b,a] = butter(4,Wn,'low');
yaw_lpf = filter(b,a,yaw_mag);

fs = 100; 
fc = 1;  
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

figure;
hold on;
plot(time_mag , yaw_mag,'Color', 'b');
plot(time , yaw_gyro,'Color', 'g');
plot(time_mag , yaw_cf,'Color' ,'r');
title('Comparison');
xlabel('Time (nanoseconds) ');
ylabel('Yaw Angle (Radians)');
legend('Raw','Mag','Gyro','Comp');
grid on;
