require "ffi"
require "fasttcx/structs/activity"

module FastTCX
  module Structs
    class TCX < FFI::Struct
      layout \
        :activities, FastTCX::Structs::Activity.ptr
    end
  end
end
