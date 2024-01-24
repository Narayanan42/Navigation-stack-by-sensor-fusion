;; Auto-generated. Do not edit!


(when (boundp 'gps_driver::gps_msg)
  (if (not (find-package "GPS_DRIVER"))
    (make-package "GPS_DRIVER"))
  (shadow 'gps_msg (find-package "GPS_DRIVER")))
(unless (find-package "GPS_DRIVER::GPS_MSG")
  (make-package "GPS_DRIVER::GPS_MSG"))

(in-package "ROS")
;;//! \htmlinclude gps_msg.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass gps_driver::gps_msg
  :super ros::object
  :slots (_Header _Latitude _Longitude _Altitude _utm_easting _utm_northing _zone _letter ))

(defmethod gps_driver::gps_msg
  (:init
   (&key
    ((:Header __Header) (instance std_msgs::Header :init))
    ((:Latitude __Latitude) 0.0)
    ((:Longitude __Longitude) 0.0)
    ((:Altitude __Altitude) 0.0)
    ((:utm_easting __utm_easting) 0.0)
    ((:utm_northing __utm_northing) 0.0)
    ((:zone __zone) 0.0)
    ((:letter __letter) "")
    )
   (send-super :init)
   (setq _Header __Header)
   (setq _Latitude (float __Latitude))
   (setq _Longitude (float __Longitude))
   (setq _Altitude (float __Altitude))
   (setq _utm_easting (float __utm_easting))
   (setq _utm_northing (float __utm_northing))
   (setq _zone (float __zone))
   (setq _letter (string __letter))
   self)
  (:Header
   (&rest __Header)
   (if (keywordp (car __Header))
       (send* _Header __Header)
     (progn
       (if __Header (setq _Header (car __Header)))
       _Header)))
  (:Latitude
   (&optional __Latitude)
   (if __Latitude (setq _Latitude __Latitude)) _Latitude)
  (:Longitude
   (&optional __Longitude)
   (if __Longitude (setq _Longitude __Longitude)) _Longitude)
  (:Altitude
   (&optional __Altitude)
   (if __Altitude (setq _Altitude __Altitude)) _Altitude)
  (:utm_easting
   (&optional __utm_easting)
   (if __utm_easting (setq _utm_easting __utm_easting)) _utm_easting)
  (:utm_northing
   (&optional __utm_northing)
   (if __utm_northing (setq _utm_northing __utm_northing)) _utm_northing)
  (:zone
   (&optional __zone)
   (if __zone (setq _zone __zone)) _zone)
  (:letter
   (&optional __letter)
   (if __letter (setq _letter __letter)) _letter)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _Header
    (send _Header :serialization-length)
    ;; float64 _Latitude
    8
    ;; float64 _Longitude
    8
    ;; float64 _Altitude
    8
    ;; float64 _utm_easting
    8
    ;; float64 _utm_northing
    8
    ;; float64 _zone
    8
    ;; string _letter
    4 (length _letter)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _Header
       (send _Header :serialize s)
     ;; float64 _Latitude
       (sys::poke _Latitude (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _Longitude
       (sys::poke _Longitude (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _Altitude
       (sys::poke _Altitude (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _utm_easting
       (sys::poke _utm_easting (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _utm_northing
       (sys::poke _utm_northing (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _zone
       (sys::poke _zone (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; string _letter
       (write-long (length _letter) s) (princ _letter s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _Header
     (send _Header :deserialize buf ptr-) (incf ptr- (send _Header :serialization-length))
   ;; float64 _Latitude
     (setq _Latitude (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _Longitude
     (setq _Longitude (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _Altitude
     (setq _Altitude (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _utm_easting
     (setq _utm_easting (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _utm_northing
     (setq _utm_northing (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _zone
     (setq _zone (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; string _letter
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _letter (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get gps_driver::gps_msg :md5sum-) "3d30cb8b98be86f5166d455588a3e2dd")
(setf (get gps_driver::gps_msg :datatype-) "gps_driver/gps_msg")
(setf (get gps_driver::gps_msg :definition-)
      "Header Header
float64 Latitude
float64 Longitude
float64 Altitude
float64 utm_easting
float64 utm_northing
float64 zone
string letter

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

")



(provide :gps_driver/gps_msg "3d30cb8b98be86f5166d455588a3e2dd")


