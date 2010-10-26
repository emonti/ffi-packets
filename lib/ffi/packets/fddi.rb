require 'ffi/packets/fddi.rb'

module FFI::Packets

  # Fiber Distributed Data Interface (FDDI) L2 Frame Header
  class FDDI < AutoStruct

    dsl_layout do
      field   :fc,    :uint8,   :desc => 'field control'
      struct  :dst,   FFI::Packets::MacAddr,  :desc => 'destination address'
      struct  :src,   FFI::Packets::MacAddr,  :desc => 'source address'
    end
  end
end
