#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import rospy
import roscpp
import serial
import utm
import roslib
import sys
from gps_driver.msg import gps_msg
from std_msgs.msg import Header

global line


gps_pub = rospy.Publisher('gps', gps_msg, queue_size=10)
rospy.init_node("gps", anonymous=True)
rate = rospy.Rate(1)

try:
    serial_port = rospy.get_param('~port0')
except:
    argv=sys.argv
    serial_port = str(argv[1])


serial_baud = rospy.get_param('~baudrate',4800) 
port = serial.Serial(serial_port,serial_baud)
raw_gps_string=open("gps_data.txt",'a')

def gps_reader():
      while(not rospy.is_shutdown()):

        raw_data = port.readline()
        data = str(str(raw_data))

        # data = data.decode("utf-8")

        if data[4:10] =='$GPGGA' or  data[2:8] == '$GPGGA':
        
            msg= gps_msg()
            sensor_data = data.split(',') 
            print("GPS data:", sensor_data)
            
            try: 
            
                if sensor_data[3]=='N':
                    msg.Latitude = int(sensor_data[2][0:2]) + float(sensor_data[2][2:])/60
                else: msg.Latitude = -1 * (int(sensor_data[2][0:2]) + float(sensor_data[2][2:])/60)

                if sensor_data[5]=='E':
                    msg.Longitude = int(sensor_data[4][0:3]) + float(sensor_data[4][3:])/60
                else: msg.Longitude = -1 * (int(sensor_data[4][0:3]) + float(sensor_data[4][3:])/60)
                
                # time = float(sensor_data[1])
                # time_hrs = time//10000
                # time_mint = (time-(time_hrs*10000))//100
                # time_sec = (time - (time_hrs*10000) - (time_mint*100))
                # time_final_secs = (time_hrs*3600 + time_mint*60 + time_sec)
                # time_final_nsecs = int((time_final_secs * (10**7)) % (10**7))

                time = rospy.get_rostime()

                msg.Header.stamp.secs = int(time.secs)
                msg.Header.stamp.nsecs = int(time.nsecs)
                msg.Header.frame_id = 'GPS1_Frame'
                msg.Altitude = float(sensor_data[9])
                UTM_coordinate = utm.from_latlon(msg.Latitude, msg.Longitude)
                msg.utm_easting = UTM_coordinate[0]
                msg.utm_northing = UTM_coordinate[1]
                msg.zone = UTM_coordinate[2]
                msg.letter = UTM_coordinate[3]
                
                # msg.Header.stamp.secs = int(time_final_secs)
                # msg.Header.stamp.nsecs = time_final_nsecs
                
                gps_pub.publish(msg)
                raw_gps_string.write(str(msg))

            except Exception as e:
                    print("Error Encountered" , e) 
                    msg.Header.frame_id = 'GPS1_Frame'
                    msg.Altitude = 0.0
                    msg.utm_easting = 0.0
                    msg.utm_northing = 0.0
                    msg.zone = 0.0
                    msg.letter = 'Error'
                    gps_pub.publish(msg)
                    pass  

     

if __name__=='__main__':
    try:
        gps_reader()
    except rospy.ROSInterruptException:
        pass
        port.close()
    raw_gps_string.close()




