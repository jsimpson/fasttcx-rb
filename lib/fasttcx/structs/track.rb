require "ffi"
require "fasttcx/structs/trackpoint"

module FastTCX
  module Structs
    class Track < FFI::Struct
      layout \
        :num_trackpoints, :int,
        :trackpoints, FastTCX::Structs::Trackpoint.ptr,
        :next, FastTCX::Structs::Track.ptr
    end
  end
end
