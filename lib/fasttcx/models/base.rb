require "ffi"

module FastTCX
  module Models
    class Base
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
        puts self.class.name
        puts "-" * 40
        instance_variables.each { |var| puts "#{var.to_s.gsub("@", "").ljust(20)}: #{instance_variable_get(var)}" }
        puts "=" * 40
      end
    end
  end
end
