require 'ffi'

class Coordinates < FFI::Struct
  layout \
    :latitude, :double,
    :longitude, :double
end

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
    :next, Trackpoint.ptr
end

class Track < FFI::Struct
  layout \
    :num_trackpoints, :int,
    :trackpoints, Trackpoint.ptr,
    :next, Track.ptr
end

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
    :tracks, Track.ptr,
    :next, Lap.ptr
end

class Activity < FFI::Struct
    layout \
      :num_trackpoints, :int,
      :num_laps, :int,
      :started_at, :pointer,
      :ended_at, :pointer,
      :total_time, :double,
      :start_point, Coordinates.ptr,
      :end_point, Coordinates.ptr,
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
      :laps, Lap.ptr,
      :next, Activity.ptr
end

class TCX < FFI::Struct
  layout \
    :activities, Activity.ptr
end

module FastTCX
  class C
    extend FFI::Library

    ffi_lib "./libfasttcx.so"

    functions = [
      [:parse_tcx_file, [TCX.by_ref, :pointer], :int],
      [:calculate_summary, [TCX.by_ref], :void],
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
      @tcx = TCX.new
      @file = file
    end

    def parse
      FastTCX::C.parse_tcx_file(@tcx, @file)
    end

    def process
      FastTCX::C.calculate_summary(@tcx)
    end

    def print_laps
      lap = laps
      while !lap[:next].null?
        puts "lap: #{lap[:heart_rate_average]}"
        lap = lap[:next]
      end
    end

    private

    def laps
      @laps ||= @tcx[:activities][:laps]
    end
  end
end

fasttcx = FastTCX::Ruby.new("/Users/jsimpson/projects/github/js/fasttcx-rb/test.tcx")
fasttcx.parse
fasttcx.process
fasttcx.print_laps

