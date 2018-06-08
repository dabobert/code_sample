class SalesRepDrop < DpLiquidDrop

  def name
    span_tag @source.name, @options["marked_red"]
  end

  def email_label
    span_tag "Email:", @options["marked_red"]
  end

  def email
    span_tag @source.email, @options["marked_red"]
  end

  def office_phone_label
    span_tag "Office Phone:", @options["marked_red"]
  end

  def office_phone
    if @source.office_phone.present_as_string?
      span_tag @source.office_phone, @options["marked_red"]
    end
  end

  def mobile_phone_label
    span_tag "Mobile Phone:", @options["marked_red"]
  end

  def mobile_phone
    if @source.mobile_phone.present?
      span_tag @source.mobile_phone, @options["marked_red"]
    end
  end

end