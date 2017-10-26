require "ffi"

module FastTCX
  module Structs
    class Trackpoint < FFI::Struct
      layout \
        :time, :pointer,
        :latitude, :double,
        :longitude, :double,
        :elevation, :double,
        :distance, :double,
        :heart_rate, :int,
        :cadence, :int,
        :speed, :double,
        :power, :int,
        :next, FastTCX::Structs::Trackpoint.ptr
    end
  end
end
