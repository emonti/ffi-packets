module FFI::Packets
  module ARCNET

    # Structure of a 2.5MB/s Arcnet header on the BSDs,
    # as given to interface code.
    class Hdr < FFI::Struct
      include ::FFI::DRY::NetStructHelper

      dsl_layout do
        field :arc_shost, :uint8
        field :arc_dhost, :uint8
        field :arc_type,  :uint8

        # possibly followed by LL Frag
        # possibly followed by Exception
      end
    end

    class LLFrag < FFI::Struct
      include ::FFI::DRY::NetStructHelper

      dsl_layout do
        field :arc_flag,  :uint8
        field :arc_seqid, :uint16
      end
    end

    class Exception < FFI::Struct
      include ::FFI::DRY::NetStructHelper

      dsl_layout do
        field :arc_type2,   :uint8
        field :arc_flag2,   :uint8
        field :arc_seqid2,  :uint16
      end
    end

    # Structure of a 2.5MB/s Arcnet header on Linux.  Linux has
    # an extra "offset" field when given to interface code, and
    # never presents packets that look like exception frames.
    class LinuxHdr < FFI::Struct
      include ::FFI::DRY::NetStructHelper

      dsl_layout do
        field :arc_shost,   :uint8
        field :arc_dhost,   :uint8
        field :arc_offset,  :uint16
        field :arc_type,    :uint8

        # possibly followed by LL frag 
      end
    end

  end

end
