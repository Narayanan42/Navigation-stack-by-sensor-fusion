;; Auto-generated. Do not edit!


(when (boundp 'imu_driver::imu_msg)
  (if (not (find-package "IMU_DRIVER"))
    (make-package "IMU_DRIVER"))
  (shadow 'imu_msg (find-package "IMU_DRIVER")))
(unless (find-package "IMU_DRIVER::IMU_MSG")
  (make-package "IMU_DRIVER::IMU_MSG"))

(in-package "ROS")
;;//! \htmlinclude imu_msg.msg.html
(if (not (find-package "SENSOR_MSGS"))
  (ros::roseus-add-msgs "sensor_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass imu_driver::imu_msg
  :super ros::object
  :slots (_Header _time _IMU _MagField _imu_string ))

(defmethod imu_driver::imu_msg
  (:init
   (&key
    ((:Header __Header) (instance std_msgs::Header :init))
    ((:time __time) 0.0)
    ((:IMU __IMU) (instance sensor_msgs::Imu :init))
    ((:MagField __MagField) (instance sensor_msgs::MagneticField :init))
    ((:imu_string __imu_string) "")
    )
   (send-super :init)
   (setq _Header __Header)
   (setq _time (float __time))
   (setq _IMU __IMU)
   (setq _MagField __MagField)
   (setq _imu_string (string __imu_string))
   self)
  (:Header
   (&rest __Header)
   (if (keywordp (car __Header))
       (send* _Header __Header)
     (progn
       (if __Header (setq _Header (car __Header)))
       _Header)))
  (:time
   (&optional __time)
   (if __time (setq _time __time)) _time)
  (:IMU
   (&rest __IMU)
   (if (keywordp (car __IMU))
       (send* _IMU __IMU)
     (progn
       (if __IMU (setq _IMU (car __IMU)))
       _IMU)))
  (:MagField
   (&rest __MagField)
   (if (keywordp (car __MagField))
       (send* _MagField __MagField)
     (progn
       (if __MagField (setq _MagField (car __MagField)))
       _MagField)))
  (:imu_string
   (&optional __imu_string)
   (if __imu_string (setq _imu_string __imu_string)) _imu_string)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _Header
    (send _Header :serialization-length)
    ;; float64 _time
    8
    ;; sensor_msgs/Imu _IMU
    (send _IMU :serialization-length)
    ;; sensor_msgs/MagneticField _MagField
    (send _MagField :serialization-length)
    ;; string _imu_string
    4 (length _imu_string)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _Header
       (send _Header :serialize s)
     ;; float64 _time
       (sys::poke _time (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; sensor_msgs/Imu _IMU
       (send _IMU :serialize s)
     ;; sensor_msgs/MagneticField _MagField
       (send _MagField :serialize s)
     ;; string _imu_string
       (write-long (length _imu_string) s) (princ _imu_string s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _Header
     (send _Header :deserialize buf ptr-) (incf ptr- (send _Header :serialization-length))
   ;; float64 _time
     (setq _time (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; sensor_msgs/Imu _IMU
     (send _IMU :deserialize buf ptr-) (incf ptr- (send _IMU :serialization-length))
   ;; sensor_msgs/MagneticField _MagField
     (send _MagField :deserialize buf ptr-) (incf ptr- (send _MagField :serialization-length))
   ;; string _imu_string
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _imu_string (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get imu_driver::imu_msg :md5sum-) "f9d2e951f581dc7875d4036d9944fbf3")
(setf (get imu_driver::imu_msg :datatype-) "imu_driver/imu_msg")
(setf (get imu_driver::imu_msg :definition-)
      "Header Header
float64 time
sensor_msgs/Imu IMU
sensor_msgs/MagneticField MagField
string imu_string

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

================================================================================
MSG: sensor_msgs/Imu
# This is a message to hold data from an IMU (Inertial Measurement Unit)
#
# Accelerations should be in m/s^2 (not in g's), and rotational velocity should be in rad/sec
#
# If the covariance of the measurement is known, it should be filled in (if all you know is the 
# variance of each measurement, e.g. from the datasheet, just put those along the diagonal)
# A covariance matrix of all zeros will be interpreted as \"covariance unknown\", and to use the
# data a covariance will have to be assumed or gotten from some other source
#
# If you have no estimate for one of the data elements (e.g. your IMU doesn't produce an orientation 
# estimate), please set element 0 of the associated covariance matrix to -1
# If you are interpreting this message, please check for a value of -1 in the first element of each 
# covariance matrix, and disregard the associated estimate.

Header header

geometry_msgs/Quaternion orientation
float64[9] orientation_covariance # Row major about x, y, z axes

geometry_msgs/Vector3 angular_velocity
float64[9] angular_velocity_covariance # Row major about x, y, z axes

geometry_msgs/Vector3 linear_acceleration
float64[9] linear_acceleration_covariance # Row major x, y z 

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w

================================================================================
MSG: geometry_msgs/Vector3
# This represents a vector in free space. 
# It is only meant to represent a direction. Therefore, it does not
# make sense to apply a translation to it (e.g., when applying a 
# generic rigid transformation to a Vector3, tf2 will only apply the
# rotation). If you want your data to be translatable too, use the
# geometry_msgs/Point message instead.

float64 x
float64 y
float64 z
================================================================================
MSG: sensor_msgs/MagneticField
 # Measurement of the Magnetic Field vector at a specific location.

 # If the covariance of the measurement is known, it should be filled in
 # (if all you know is the variance of each measurement, e.g. from the datasheet,
 #just put those along the diagonal)
 # A covariance matrix of all zeros will be interpreted as \"covariance unknown\",
 # and to use the data a covariance will have to be assumed or gotten from some
 # other source


 Header header                        # timestamp is the time the
                                      # field was measured
                                      # frame_id is the location and orientation
                                      # of the field measurement

 geometry_msgs/Vector3 magnetic_field # x, y, and z components of the
                                      # field vector in Tesla
                                      # If your sensor does not output 3 axes,
                                      # put NaNs in the components not reported.

 float64[9] magnetic_field_covariance # Row major about x, y, z axes
                                      # 0 is interpreted as variance unknown
")



(provide :imu_driver/imu_msg "f9d2e951f581dc7875d4036d9944fbf3")


