class ProjectProductRoomDrop < DpLiquidDrop

  def number
    @source.try(:key).try(:number)
  end

  def value
    @source.try(:key).try(:value)
  end

  def units
    nil_or_integer_value @source.try(:units)
  end

end