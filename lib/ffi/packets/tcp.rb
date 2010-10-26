module FFI::Packets
  module TCP

    # TCP header, without options
    class Hdr < AutoStruct
    
      dsl_layout do
        field :sport,  :uint16, :desc => 'source port'
        field :dport,  :uint16, :desc => 'destination port'
        field :seq,    :uint32, :desc => 'sequence number'
        field :ack,    :uint32, :desc => 'acknowledgment number'
        field :off_x2, :uint8,  :desc => 'data offset(& 0xf0) unused (& 0x0f)'
        field :flags,  :uint8,  :desc => 'control flags'
        field :win,    :uint16, :desc => 'window'
        field :sum,    :uint16, :desc => 'checksum'
        field :urgp,   :uint16, :desc => 'urgent pointer'
      end

      def offset
        (off_x2 & 0xf0) >> 4
      end
      
      def offset=(val)
        off_x2 = ((val 0x0f) << 4 ) + (off_x2 & 0x0f)
      end

      # TCP control flags (flags)
      module Flags
        include ::FFI::DRY::ConstFlagsMap
        slurp_constants(Constants, "TH_")
        def self.list; @@list ||= super() ; end
      end

    end

    # TCP option (following TCP header)
    #
    class Opt < AutoStruct
      TCP_OPT_LEN = Constants::TCP_OPT_LEN
      TCP_OPT_LEN_MAX = Constants::TCP_OPT_LEN_MAX
      MAX_DATA_LEN = TCP_OPT_LEN_MAX - TCP_OPT_LEN
 
      class Data < FFI::Union
        include ::FFI::DRY::NetStructHelper

        maxlen = Opt::MAX_DATA_LEN

        dsl_layout do 
          field :mss,     :uint16,        :desc => 'TCP_OPT_MSS'
          field :wscale,  :uint8,         :desc => 'TCP_OPT_WSCALE'
          array :sack,    [:uint16, 19],  :desc => 'TCP_OPT_WSCALE'
          field :echo,    :uint32,        :desc => 'TCP_OPT_ECHO{REPLY}'
          array :timestamp, [:uint32, 2], :desc => 'TCP_OPT_TIMESTAMP'
          field :cc,      :uint32,        :desc => 'TCP_OPT_CC{NEW,ECHO}'
          field :cksum,   :uint8,         :desc => 'TCP_OPT_ALTSUM'
          array :md5,     [:uint8, 16],   :desc => 'TCP_OPT_MD5'
          array :data8,   [:uint8, maxlen]
        end
      end

      data_hdr = Data
   
      dsl_layout do
        field  :otype,    :uint8, :desc => 'option type'
        field  :len,      :uint8, :desc => 'option length >= TCP_OPT_LEN'
        union  :opt_data, data_hdr, :offset => 2,  :desc => 'tcp option data'
      end

      # overrides copy size to account for alignment errors
      def copy_size
        MAX_DATA_LEN + 2
      end

      # Options (otype) - http://www.iana.org/assignments/tcp-parameters
      module Otype
        include ::FFI::DRY::ConstMap
        slurp_constants(Constants, "TCP_OTYPE_")
        def self.list; @@list ||= super() ; end
      end

      def lookup_otype
        Otype[ self[:otype] ]
      end

    end # class Opt

    # TCP FSM states
    module State
      include ::FFI::DRY::ConstMap
      slurp_constants(Constants, "TCP_STATE_")
      def self.list; @@list ||= super() ; end
    end

  end # module Tcp
end 

