data = readtable('imu.csv');

timestamp_end = 1698236028296410000;
data_end = data(data.x_time <= timestamp_end, :);
data = data_end;


mx = data.field_MagField_magnetic_field_x;  
my = data.field_MagField_magnetic_field_y;
mz = data.field_MagField_magnetic_field_z;
gz = data.field_IMU_angular_velocity_z;
time  = data.x_time;
time = time - min(time);
mx_offset = mean(mx); 
my_offset = mean(my);
mx_hi = mx - mx_offset;
my_hi = my - my_offset;

mx_major = mx_hi(2000); 
my_major = my_hi(2000);
theta = asin(my_major ./ sqrt(mx_major.^2 + my_major.^2));
maj_a = [cos(theta) sin(theta); -sin(theta) cos(theta)];
mx_hi = mx_hi.'; 
my_hi = my_hi.';
v_hi = maj_a * [mx_hi; my_hi];  

figure;
plot(mx,my,'+','DisplayName','Uncalibrated');  
hold on;
plot(mx_hi,my_hi,'o','DisplayName','Hard Iron Calibrated');  
plot(v_hi(1,:),v_hi(2,:),'x','DisplayName','Soft Iron Calibrated');
legend;
title('Calibrated vs Uncalibrated');
xlabel('X (Gauss)');
ylabel('Y (Gauss)');

figure;
plot(mx_hi,my_hi,'+','DisplayName','Hard Iron Calibrated');  
hold on;
plot(v_hi(1,:),v_hi(2,:),'x','DisplayName','Soft Iron Calibrated');
legend;
title('Hard and Soft Iron Calibration');
xlabel('X (Gauss)');
ylabel('Y (Gauss)');  

r = abs(mx_hi/2);
q = abs(my_hi/2);
sigma = q/r;

S = [1 0; 0 sigma]; 
xyScaled = S*v_hi;

theta2 = theta;
min_a = [cos(theta2) sin(theta2); -sin(theta2) cos(theta2)];
xyFinal = min_a*xyScaled;

figure;
plot(xyFinal(1,:),xyFinal(2,:),'o','DisplayName','Final Calibrated'); 
legend;
title('Final Calibration');
xlabel('X (Gauss)'); 
ylabel('Y (Gauss)');

mx_si = v_hi(1,:);  
my_si = sigma*v_hi(2,:);

disp(maj_a);
disp(min_a);
