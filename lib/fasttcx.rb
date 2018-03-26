require "ffi"
require "fasttcx/models/base"
require "fasttcx/models/lap"
require "fasttcx/structs/tcx"

module FastTCX
  class C
    extend FFI::Library

    ffi_lib "bin/libfasttcx.so"

    functions = [
      [:parse_tcx_file, [FastTCX::Structs::TCX.by_ref, :pointer], :int],
      [:calculate_summary, [FastTCX::Structs::TCX.by_ref], :void],
    ]

    functions.each do |function|
      begin
        attach_function(*function)
      rescue Object => e
        puts "Could not attach #{function}, #{e.message}"
      end
    end
  end

  class Ruby
    def initialize(file)
      @tcx = FastTCX::Structs::TCX.new
      @file = file
    end

    def parse
      FastTCX::C.parse_tcx_file(@tcx, @file)
    end

    def process
      FastTCX::C.calculate_summary(@tcx)
    end

    def print_laps
      laps.each { |lap| lap.print }
    end

    def tcx
      @tcx
    end


    def activities
      @activities ||= @tcx[:activities]
    end

    def laps
      @laps ||= begin
        lap = activities[:laps]
        while !lap[:next].null?
          _laps << FastTCX::Models::Lap.from_struct(lap)
          lap = lap[:next]
        end
        _laps
      end
    end

    private

    def _laps
      @_laps ||= []
    end

    def tracks
      @tracks ||= laps[:tracks]
    end

    def trackpoints
      @trackpoints ||= tracks[:trackpoints]
    end
  end
end
