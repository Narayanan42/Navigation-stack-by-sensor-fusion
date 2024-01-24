#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys
import math as m
import rospy
import serial
from std_msgs.msg import Header
from imu_driver.msg import imu_msg

global line

imu_pub = rospy.Publisher('imu', imu_msg, queue_size=10)
rospy.init_node("imu", anonymous=True)
# rate = rospy.Rate(40)

try:
    serial_port = rospy.get_param('~port1')
except:
    argv=sys.argv
    serial_port = str(argv[1])

serial_baud = rospy.get_param('~baudrate',115200) 
port = serial.Serial(serial_port,serial_baud, timeout = 3)

port.write(b"$VNWRG,07,40*xx")
raw_imu_string=open("imu_data.txt",'a')

def imu_reader():
    while(not rospy.is_shutdown()):
        raw_data = port.readline()
        data = str(raw_data)

        if data[4:10] =='$VNYMR' or  data[2:8] == '$VNYMR':

            msg = imu_msg()
            sensor_data = data.split(',')        
            print("IMU data:", sensor_data)
            
            time = rospy.get_rostime()
            yaw = float(sensor_data[1])
            pitch = float(sensor_data[2])
            roll = float(sensor_data[3])
            magnetometerX = float(sensor_data[4])
            magnetometerY = float(sensor_data[5])
            magnetometerZ = float(sensor_data[6])
            accelerometerX = float(sensor_data[7])
            accelerometerY = float(sensor_data[8])
            accelerometerZ = float(sensor_data[9])
            gyroX = float(sensor_data[10])
            gyroY = float(sensor_data[11])
            gyroZ = float(sensor_data[12][0:9])


            quaternionx = m.sin(roll/2) * m.cos(pitch/2) * m.cos(yaw/2) - m.cos(roll/2) * m.sin(pitch/2) * m.sin(yaw/2)
            quaterniony = m.cos(roll/2) * m.sin(pitch/2) * m.cos(yaw/2) + m.sin(roll/2) * m.cos(pitch/2) * m.sin(yaw/2)
            quaternionz = m.cos(roll/2) * m.cos(pitch/2) * m.sin(yaw/2) - m.sin(roll/2) * m.sin(pitch/2) * m.cos(yaw/2)
            quaternionw = m.cos(roll/2) * m.cos(pitch/2) * m.cos(yaw/2) + m.sin(roll/2) * m.sin(pitch/2) * m.sin(yaw/2)


            msg.Header.stamp.secs = int(time.secs)
            msg.Header.stamp.nsecs = int(time.nsecs)
            msg.Header.frame_id = 'IMU1_Frame'
            msg.IMU.orientation.x = quaternionx
            msg.IMU.orientation.y = quaterniony
            msg.IMU.orientation.z = quaternionz
            msg.IMU.orientation.w = quaternionw
            msg.IMU.angular_velocity.x = gyroX
            msg.IMU.angular_velocity.y = gyroY
            msg.IMU.angular_velocity.z = gyroZ
            msg.IMU.linear_acceleration.x = accelerometerX
            msg.IMU.linear_acceleration.y = accelerometerY
            msg.IMU.linear_acceleration.z = accelerometerZ
            msg.MagField.magnetic_field.x = magnetometerX
            msg.MagField.magnetic_field.y = magnetometerY
            msg.MagField.magnetic_field.z = magnetometerZ

            imu_pub.publish(msg)
            raw_imu_string.write(str(msg))
            

if __name__ == '__main__':
    try:
        imu_reader()
    except rospy.ROSInterruptException:
        pass
        port.close()
    raw_imu_string.close()