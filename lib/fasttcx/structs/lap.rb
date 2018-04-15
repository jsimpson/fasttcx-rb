require "ffi"
require "fasttcx/structs/track"

module FastTCX
  module Structs
    class Lap < FFI::Struct
      layout \
        :num_tracks, :int,
        :num_trackpoints, :int,
        :start_time, :pointer,
        :total_time, :double,
        :distance, :double,
        :calories, :int,
        :speed_average, :double,
        :speed_maximum, :double,
        :speed_minimum, :double,
        :heart_rate_average, :int,
        :heart_rate_maximum, :int,
        :heart_rate_minimum, :int,
        :intensity, :pointer,
        :cadence_average, :int,
        :cadence_maximum, :int,
        :cadence_minimum, :int,
        :elevation_maximum, :double,
        :elevation_minimum, :double,
        :total_elevation_gain, :double,
        :total_elevation_loss, :double,
        :grade_adjusted_time, :double,
        :tracks, FastTCX::Structs::Track.ptr,
        :next, FastTCX::Structs::Lap.ptr
    end
  end
end
