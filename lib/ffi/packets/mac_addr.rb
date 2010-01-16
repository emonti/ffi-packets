
module FFI::Packets
  class MacAddr < ::FFI::Struct
    include ::FFI::DRY::StructHelper

    # struct eth_addr { ... } eth_addr_t;
    dsl_layout{ array :data, [:uchar, Constants::ETH_ADDR_LEN] }

    # Adds the ability to initialize a new MacAddr with a mac address
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
    def string
      chars.map {|x| "%0.2x" % x }.join(':')
    end

    alias addr string

    def inspect
      "#<#{self.class} data=#{addr}>"
    end
  end
end
