
module FFI
  module Packets
    class AutoStruct < FFI::Struct
      include ::FFI::DRY::NetStructHelper

      def self.describe
        specs = dsl_metadata()
        nsz = members.map{|n| n.to_s.size }.sort.last
        tsz = specs.map{|t| t[:type].inspect.size }.sort.last
        specs.map do |spec|
          "  " <<
          spec[:name].to_s.rjust(nsz) <<  "    " <<
          spec[:type].inspect.ljust(tsz) << "    " <<
          spec[:desc].to_s
        end
      end

      def nested?
        @nested_struct == true
      end

      def describe
        self.class.describe
      end

      def dump
        nsz = members.map{|n| n.to_s.size }.max

        # return a formatted "dump" of fields and values
        members.map do |field|
          val = self.__send__(field)
          "  #{field.to_s.rjust(nsz)} = #{val.inspect}"
        end.unshift(self.class.name)
      end
    end
  end
end
