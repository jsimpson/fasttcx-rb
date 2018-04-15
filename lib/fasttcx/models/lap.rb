require "fasttcx/models/base"

module FastTCX
  module Models
    class Lap < Base
      attr_accessor :num_tracks, :num_trackpoints, :intensity,
        :start_time, :total_time, :distance, :calories,
        :speed_average, :speed_maximum, :speed_minimum,
        :heart_rate_average, :heart_rate_maximum, :heart_rate_minimum,
        :cadence_average, :cadence_maximum, :cadence_minimum,
        :elevation_maximum, :elevation_minimum, :total_elevation_gain, :total_elevation_loss,
        :grade_adjusted_time
    end
  end
end
