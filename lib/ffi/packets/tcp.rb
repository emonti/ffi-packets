module FFI::Packets
  module Tcp

    # TCP header, without options
    #
    #   field :sport,  :uint16, :desc => 'source port'
    #   field :dport,  :uint16, :desc => 'destination port'
    #   field :seq,    :uint32, :desc => 'sequence number'
    #   field :ack,    :uint32, :desc => 'acknowledgment number'
    #   field :off_x2, :uint8,  :desc => 'data offset(& 0xf0) unused (& 0x0f)'
    #   field :flags,  :uint8,  :desc => 'control flags'
    #   field :win,    :uint16, :desc => 'window'
    #   field :sum,    :uint16, :desc => 'checksum'
    #   field :urgp,   :uint16, :desc => 'urgent pointer'
    #
    class Hdr < ::FFI::Struct
      include ::FFI::DRY::NetStructHelper
    
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

      # TCP control flags (flags)
      module Flags
        include ::FFI::DRY::ConstFlagsMap
        slurp_constants(Constants, "TH_")
        def self.list; @@list ||= super() ; end
      end

      #  #define \
      #    tcp_pack_hdr(hdr, sport, dport, seq, ack, flags, win, urp) do { \
      #      struct tcp_hdr *tcp_pack_p = (struct tcp_hdr *)(hdr);    \
      #      tcp_pack_p->th_sport = htons(sport);                     \
      #      tcp_pack_p->th_dport = htons(dport);                     \
      #      tcp_pack_p->th_seq = htonl(seq);                         \
      #      tcp_pack_p->th_ack = htonl(ack);                         \
      #      tcp_pack_p->th_x2 = 0; tcp_pack_p->th_off = 5;           \
      #      tcp_pack_p->th_flags = flags;                            \
      #      tcp_pack_p->th_win = htons(win);                         \
      #      tcp_pack_p->th_urp = htons(urp);                         \
      #  } while (0)

    end

    #
    # TCP option (following TCP header)
    #
    #   struct tcp_opt {
    #      uint8_t        opt_type;  /* option type */
    #      uint8_t        opt_len;   /* option length >= TCP_OPT_LEN */
    #      union tcp_opt_data {
    #        uint16_t    mss;           /* TCP_OPT_MSS */
    #        uint8_t        wscale;     /* TCP_OPT_WSCALE */
    #        uint16_t    sack[19];      /* TCP_OPT_SACK */
    #        uint32_t    echo;          /* TCP_OPT_ECHO{REPLY} */
    #        uint32_t    timestamp[2];  /* TCP_OPT_TIMESTAMP */
    #        uint32_t    cc;            /* TCP_OPT_CC{NEW,ECHO} */
    #        uint8_t        cksum;      /* TCP_OPT_ALTSUM */
    #        uint8_t        md5[16];    /* TCP_OPT_MD5 */
    #        uint8_t        data8[TCP_OPT_LEN_MAX - TCP_OPT_LEN];
    #      } opt_data;
    #   } __attribute__((__packed__));
    #
    class Opt < ::FFI::Struct
      include ::FFI::DRY::NetStructHelper

      TCP_OPT_LEN = Constants::TCP_OPT_LEN
      TCP_OPT_LEN_MAX = Constants::TCP_OPT_LEN_MAX

      DATA_LEN = TCP_OPT_LEN_MAX - TCP_OPT_LEN
    
      dsl_layout do
        field :otype,  :uint8
        field :len,    :uint8
        array :data8,  [:uint8, DATA_LEN]
      end

      # Options (otype) - http://www.iana.org/assignments/tcp-parameters
      module Otype
        include ::FFI::DRY::ConstMap
        slurp_constants(Constants, "TCP_OTYPE_")
        def self.list; @@list ||= super() ; end
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

