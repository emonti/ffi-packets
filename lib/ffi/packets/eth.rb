require 'ffi/packets/mac_addr'

module FFI::Packets

  class Eth < AutoStruct
    
    module Etype
      include ::FFI::DRY::ConstMap
      slurp_constants Constants, "ETH_TYPE_"
      def list; @@list ||= super();  end
    end

    dsl_layout do
      struct :dst,   FFI::Packets::MacAddr, :desc => 'destination address'
      struct :src,   FFI::Packets::MacAddr, :desc => 'source address'
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
