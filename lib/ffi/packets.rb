
begin ; require 'rubygems'; rescue LoadError; end
require 'ffi'
require 'ffi/dry'

require 'ffi/packets/constants'
require 'ffi/packets/util'

require 'ffi/packets/eth'
require 'ffi/packets/ip'
require 'ffi/packets/arp'
require 'ffi/packets/icmp'
require 'ffi/packets/tcp'
require 'ffi/packets/udp'
