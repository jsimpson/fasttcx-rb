require "ffi"
require "fasttcx/structs/coordinates"
require "fasttcx/structs/lap"

module FastTCX
  module Structs
    class Activity < FFI::Struct
        layout \
          :num_trackpoints, :int,
          :num_laps, :int,
          :started_at, :pointer,
          :ended_at, :pointer,
          :total_time, :double,
          :start_point, FastTCX::Structs::Coordinates.ptr,
          :end_point, FastTCX::Structs::Coordinates.ptr,
          :latitude, :double,
          :longitude, :double,
          :total_calories, :int,
          :total_distance, :double,
          :total_elevation_gain, :double,
          :total_elevation_loss, :double,
          :speed_average, :double,
          :speed_maximum, :double,
          :speed_minimum, :double,
          :elevation_maximum, :double,
          :elevation_minimum, :double,
          :cadence_average, :int,
          :cadence_maximum, :int,
          :cadence_minimum, :int,
          :heart_rate_average, :int,
          :heart_rate_minimum, :int,
          :heart_rate_maximum, :int,
          :laps, FastTCX::Structs::Lap.ptr,
          :next, FastTCX::Structs::Activity.ptr
    end
  end
end
