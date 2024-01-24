% Read in CSV data 
data_imu = readtable('imu.csv');
data_gps = readtable('gps.csv');

easting = data_gps.field_utm_easting;
northing = data_gps.field_utm_northing;
time_gps = data_gps.x_time;
time_imu = data_imu.x_time;

time_imu = (time_imu - min(time_imu));
time_gps = (time_gps - min(time_gps));

acc_x = data_imu.field_IMU_linear_acceleration_x;
acc_x = acc_x - 0.2;
acc_x = lowpass(acc_x , 0.1, 2);

vel_x = cumtrapz(time_imu , acc_x);
vel_x = vel_x / 10^9;

d_easting = easting - mean(easting);
d_northing = northing - mean(northing);

distance = sqrt(d_easting.^2 + d_northing.^2);
vel_gps = diff(distance);
time_gps(1)=[];

figure;
plot(time_imu , acc_x );
% xlabel('Time'); 
% ylabel('Acceleration_x');

figure;
hold on;
plot(time_imu , abs(vel_x)); 
plot(time_gps , abs(vel_gps)); 
legend('Velocity(Magnetometer)','Velocity(GNSS)');
title('Velocity. in X');
xlabel('Time'); 
ylabel('Acceleration');
grid on;
