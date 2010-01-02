# Address resolution Protocol

module FFI::Packets
  module Arp
    # ARP header
    # 
    #   field :hrd, :uint16, :desc => 'format of hardware address'
    #   field :pro, :uint16, :desc => 'format of protocol address'
    #   field :hln, :uint16, :desc => 'length of hw address (ETH_ADDR_LEN)'
    #   field :pln, :uint16, :desc => 'length of proto address (IP_ADDR_LEN)'
    #   field :op,  :uint16, :desc => 'operation'
    class Hdr < ::FFI::Struct
      include ::FFI::DRY::NetStructHelper
      
      dsl_layout do
        field :hrd, :uint16, :desc => 'format of hardware address'
        field :pro, :uint16, :desc => 'format of protocol address'
        field :hln, :uint16, :desc => 'length of hw address (ETH_ADDR_LEN)'
        field :pln, :uint16, :desc => 'length of proto address (IP_ADDR_LEN)'
        field :op,  :uint16, :desc => 'operation'
      end

      # ARP operations
      module Op
        Constants.constants.grep(/^(ARP_OP_([A-Z][A-Z0-9_]+))$/) do
          self.const_set $2, Constants.const_get($1)
        end

        module_function
        def list
          @@list ||= constants.inject({}){|h,c| h.merge! c => const_get(c) }
        end
      end # Op
    end # Hdr

    # Ethernet/IP ARP message
    #
    #   array :sha, [:uint8, ETH_ADDR_LEN], :desc => 'sender hardware address'
    #   array :spa, [:uint8, IP_ADDR_LEN],  :desc => 'sender protocol address'
    #   array :tha, [:uint8, ETH_ADDR_LEN], :desc => 'target hardware address'
    #   array :tpa, [:uint8, IP_ADDR_LEN],  :desc => 'target protocol address'
    #
    class Ethip < ::FFI::Struct
      include ::FFI::DRY::NetStructHelper

      dsl_layout do
        array :sha, [:uint8, ETH_ADDR_LEN], :desc => 'sender hardware address'
        array :spa, [:uint8, IP_ADDR_LEN],  :desc => 'sender protocol address'
        array :tha, [:uint8, ETH_ADDR_LEN], :desc => 'target hardware address'
        array :tpa, [:uint8, IP_ADDR_LEN],  :desc => 'target protocol address'
      end

    end # Ethip

end
