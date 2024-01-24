// Auto-generated. Do not edit!

// (in-package gps_driver.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class gps_msg {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.Header = null;
      this.Latitude = null;
      this.Longitude = null;
      this.Altitude = null;
      this.utm_easting = null;
      this.utm_northing = null;
      this.zone = null;
      this.letter = null;
    }
    else {
      if (initObj.hasOwnProperty('Header')) {
        this.Header = initObj.Header
      }
      else {
        this.Header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('Latitude')) {
        this.Latitude = initObj.Latitude
      }
      else {
        this.Latitude = 0.0;
      }
      if (initObj.hasOwnProperty('Longitude')) {
        this.Longitude = initObj.Longitude
      }
      else {
        this.Longitude = 0.0;
      }
      if (initObj.hasOwnProperty('Altitude')) {
        this.Altitude = initObj.Altitude
      }
      else {
        this.Altitude = 0.0;
      }
      if (initObj.hasOwnProperty('utm_easting')) {
        this.utm_easting = initObj.utm_easting
      }
      else {
        this.utm_easting = 0.0;
      }
      if (initObj.hasOwnProperty('utm_northing')) {
        this.utm_northing = initObj.utm_northing
      }
      else {
        this.utm_northing = 0.0;
      }
      if (initObj.hasOwnProperty('zone')) {
        this.zone = initObj.zone
      }
      else {
        this.zone = 0.0;
      }
      if (initObj.hasOwnProperty('letter')) {
        this.letter = initObj.letter
      }
      else {
        this.letter = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type gps_msg
    // Serialize message field [Header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.Header, buffer, bufferOffset);
    // Serialize message field [Latitude]
    bufferOffset = _serializer.float64(obj.Latitude, buffer, bufferOffset);
    // Serialize message field [Longitude]
    bufferOffset = _serializer.float64(obj.Longitude, buffer, bufferOffset);
    // Serialize message field [Altitude]
    bufferOffset = _serializer.float64(obj.Altitude, buffer, bufferOffset);
    // Serialize message field [utm_easting]
    bufferOffset = _serializer.float64(obj.utm_easting, buffer, bufferOffset);
    // Serialize message field [utm_northing]
    bufferOffset = _serializer.float64(obj.utm_northing, buffer, bufferOffset);
    // Serialize message field [zone]
    bufferOffset = _serializer.float64(obj.zone, buffer, bufferOffset);
    // Serialize message field [letter]
    bufferOffset = _serializer.string(obj.letter, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type gps_msg
    let len;
    let data = new gps_msg(null);
    // Deserialize message field [Header]
    data.Header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [Latitude]
    data.Latitude = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [Longitude]
    data.Longitude = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [Altitude]
    data.Altitude = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [utm_easting]
    data.utm_easting = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [utm_northing]
    data.utm_northing = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [zone]
    data.zone = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [letter]
    data.letter = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.Header);
    length += _getByteLength(object.letter);
    return length + 52;
  }

  static datatype() {
    // Returns string type for a message object
    return 'gps_driver/gps_msg';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '3d30cb8b98be86f5166d455588a3e2dd';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header Header
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new gps_msg(null);
    if (msg.Header !== undefined) {
      resolved.Header = std_msgs.msg.Header.Resolve(msg.Header)
    }
    else {
      resolved.Header = new std_msgs.msg.Header()
    }

    if (msg.Latitude !== undefined) {
      resolved.Latitude = msg.Latitude;
    }
    else {
      resolved.Latitude = 0.0
    }

    if (msg.Longitude !== undefined) {
      resolved.Longitude = msg.Longitude;
    }
    else {
      resolved.Longitude = 0.0
    }

    if (msg.Altitude !== undefined) {
      resolved.Altitude = msg.Altitude;
    }
    else {
      resolved.Altitude = 0.0
    }

    if (msg.utm_easting !== undefined) {
      resolved.utm_easting = msg.utm_easting;
    }
    else {
      resolved.utm_easting = 0.0
    }

    if (msg.utm_northing !== undefined) {
      resolved.utm_northing = msg.utm_northing;
    }
    else {
      resolved.utm_northing = 0.0
    }

    if (msg.zone !== undefined) {
      resolved.zone = msg.zone;
    }
    else {
      resolved.zone = 0.0
    }

    if (msg.letter !== undefined) {
      resolved.letter = msg.letter;
    }
    else {
      resolved.letter = ''
    }

    return resolved;
    }
};

module.exports = gps_msg;
