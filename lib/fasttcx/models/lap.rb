require "ffi"

module FastTCX
  module Models
    class Lap
      attr_accessor :num_tracks, :num_tackpoints, :intensity,
        :start_time, :total_time, :distance, :calories,
        :speed_average, :speed_maximum, :speed_minimum,
        :heart_rate_average, :heart_rate_maximum, :heart_rate_minimum,
        :cadence_average, :cadence_maximum, :cadence_minimum,
        :elevation_maximum, :elevation_maximum, :total_elevation_gain, :total_elevation_loss,

      class << self
        def from_struct(struct)
          instance = self.new
          members = struct.members
          values = struct.values

          members.each_with_index do |member, i|
            value = values[i]
            value = value.read_string if value.is_a?(FFI::Pointer)
            instance.public_send("#{member}=", value) if instance.respond_to?(member)
          end

          instance
        end
      end

      def print
        puts "lap"
        puts "-" * 40
        instance_variables.each { |var| puts "#{var.to_s.gsub("@", "").ljust(20)}: #{instance_variable_get(var)}" }
        puts "=" * 40
      end
    end
  end
end
