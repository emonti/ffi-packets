
module FFI::Packets

  module Eth
    class EthAddr < ::FFI::Struct
      include ::FFI::DRY::StructHelper

      # struct eth_addr { ... } eth_addr_t;
      dsl_layout{ array :data, [:uchar, Constants::ETH_ADDR_LEN] }

      # Adds the ability to initialize a new EthAddr with a mac address
      # string such as 'de:ad:be:ef:ba:be'. This argument is only parsed
      # if it is passed as the only String argument.
      def initialize(*args)
        if args.size == 1 and (s=args[0]).is_a? String
          super()
          self.addr = s
        else
          super(*args)
        end
      end

      def addr=(val)
        unless val.to_s =~ /^#{Util::RX_MAC_ADDR}$/
          raise(ArgumentError, "invalid mac address #{val.inspect}")
        end
        raw = Util.unhexify(val, /[:-]/)
        self[:data].to_ptr.write_string(raw, ETH_ADDR_LEN)
      end

      # Returns the MAC address as an array of unsigned char values.
      def chars; self[:data].to_a ; end

      # Returns the MAC address as a string with colon-separated hex-bytes.
      def string; chars.map {|x| "%0.2x" % x }.join(':'); end
    end


    #
    #   struct :dst,   EthAddr, :desc => 'destination address'
    #   struct :src,   EthAddr, :desc => 'source address'
    #   field  :etype, :ushort, :desc => 'ethernet payload type'
    #
    class Hdr < ::FFI::Struct
      include ::FFI::DRY::NetStructHelper
      
      module Etype
        include ::FFI::DRY::ConstMap
        slurp_constants Constants, "ETH_TYPE_"
        def list; @@list ||= super();  end
      end

      dsl_layout do
        struct :dst,   EthAddr, :desc => 'destination address'
        struct :src,   EthAddr, :desc => 'source address'
        field  :etype, :ushort, :desc => 'ethernet payload type'
      end

      def lookup_etype
        Etype[ self.etype ]
      end

      alias _divert_set_eth etype=

      def etype=(val)
        if val.kind_of? String or val.kind_of? Symbol
          val = Etype[ val ] or raise(ArgumentError, "invalid eth type #{val}")
        end
        _divert_set_eth(val)
      end
    end

  end
end
