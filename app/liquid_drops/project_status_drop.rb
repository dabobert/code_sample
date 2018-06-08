class ProjectStatusDrop < DpLiquidDrop

  def has_both_dates
    @source.date1 && @source.date2
  end

  def event_number
    if @source.event_number.present_as_string?
      "##{@source.event_number}"
    end
  end

  def event_date
    @source.event_date.strftime("%m/%d/%Y")
  end

end