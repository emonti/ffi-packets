require 'ffi/packets/mac_addr'

module FFI::Packets
  class TokenRing < AutoStruct

    dsl_layout do
      field  :ac,   :uint8,   :desc => 'access control'
      field  :fc,   :uint8,   :desc => 'frame control'
      struct :dst,  FFI::Packets::MacAddr,  :desc => 'destination address'
      struct :src,  FFI::Packets::MacAddr,  :desc => 'source address'
    end

    class RouteExtra < AutoStruct

      dsl_layout do
        field  :rcf,  :uint16,        :desc => 'rcf?'
        array  :rseg, [:uint16, 16],  :desc => 'routing segment'
      end
    end
  end
end

