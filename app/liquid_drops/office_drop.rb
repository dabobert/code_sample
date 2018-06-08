class OfficeDrop < DpLiquidDrop

  def address_single_line
    @source.address_array.join(", ")
  end

  def address_multi_line
    @source.address_array.join("<br/>")
  end
end