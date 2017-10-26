require "ffi"

module FastTCX
  module Structs
    class Coordinates < FFI::Struct
      layout \
        :latitude, :double,
        :longitude, :double
    end
  end
end
