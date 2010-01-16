
begin ; require 'rubygems'; rescue LoadError; end
require 'ffi'
require 'ffi/dry'

require 'ffi/packets/constants'
require 'ffi/packets/util'
require 'ffi/packets/auto_struct'

# L2 protocols:
require 'ffi/packets/eth'
require 'ffi/packets/arcnet'
require 'ffi/packets/fddi'
require 'ffi/packets/token_ring'
require 'ffi/packets/llc'

# L3 protocols
require 'ffi/packets/ip'
require 'ffi/packets/arp'

# L4 protocols
require 'ffi/packets/icmp'
require 'ffi/packets/tcp'
require 'ffi/packets/udp'
