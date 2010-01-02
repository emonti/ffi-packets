module FFI::Packets

  class Udp
    class Hdr < ::FFI::Struct
      include ::FFI::DRY::NetStructHelper 

      # struct udp_hdr {
      #   uint16_t	uh_sport;	/* source port */
      #  	uint16_t	uh_dport;	/* destination port */
      #  	uint16_t	uh_ulen;	/* udp length (including header) */
      #  	uint16_t	uh_sum;		/* udp checksum */
      # };
      dsl_layout do
        field :sport,   :uint16
        field :dport,   :uint16
        field :len,     :uint16
        field :sum,     :uint16
      end
    end
  end


  #  #define udp_pack_hdr(hdr, sport, dport, ulen) do {		\
  #  	struct udp_hdr *udp_pack_p = (struct udp_hdr *)(hdr);	\
  #  	udp_pack_p->uh_sport = htons(sport);			\
  #  	udp_pack_p->uh_dport = htons(dport);			\
  #  	udp_pack_p->uh_ulen = htons(ulen);			\
  #  } while (0)

end
