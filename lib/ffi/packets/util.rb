
module FFI::Packets
  module Util

    RX_IP4_ADDR = /(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)/
    RX_MAC_ADDR = /(?:(?:[a-f0-9]{1,2}[:-])?{5}[a-f0-9]{1,2})/i

    # takes a IPv4 number and returns it as a 32-bit number
    def Util.ipv4_atol(str)
      unless str =~ /^#{RX_IP4_ADDR}$/
        raise(::ArgumentError, "invalid IP address #{str.inspect}")
      else
        u32=0
        str.split('.',4).each {|o| u32 = ((u32 << 8) | o.to_i) }
        return u32
      end
    end

    # takes a 32-bit number and returns it as an IPv4 address string.
    def Util.ipv4_ltoa(int)
      unless(int.is_a? Numeric and int <= 0xffffffff)
        raise(::ArgumentError, "not a long integer: #{int.inspect}")
      end
      ret = []
      4.times do 
        ret.unshift(int & 0xff)
        int >>= 8
      end
      ret.join('.')
    end

    def Util.unhexify(str, d=/\s*/)
      str.to_s.strip.gsub(/([A-Fa-f0-9]{1,2})#{d}?/) { $1.hex.chr }
    end

    def Util.htonl(*args)
      FFI::DRY::NetEndian.htonl(*args)
    end

    def Util.htons(*args)
      FFI::DRY::NetEndian.htons(*args)
    end

    def Util.ntohl(*args)
      FFI::DRY::NetEndian.ntohl(*args)
    end

    def Util.ntohs(*args)
      FFI::DRY::NetEndian.ntohs(*args)
    end

  end # module Util

end
