
module FFI::Packets
  class LLC < FFI::Struct
    include ::FFI::DRY::NetStructHelper

    dsl_layout do
      field :dsap,    :uint8,   :desc => "Destination Service Access Point"
      field :ssap,    :uint8,   :desc => "Source Service Access Point"
      field :control, :uint8,   :desc => "Control field"
    end
  end
end
