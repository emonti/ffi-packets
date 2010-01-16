module FFI::Packets

  class UDP < AutoStruct
    dsl_layout do
      field :sport,   :uint16, :desc => 'source port'
      field :dport,   :uint16, :desc => 'destination port'
      field :len,     :uint16, :desc => 'udp length (including header)'
      field :sum,     :uint16, :desc => 'udp checksum'
    end
  end

end
