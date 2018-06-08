class CustomSpecificationDrop < DpLiquidDrop

  def key
    if @source.is_divider?
      string = "#{template_objects["template_values"]["char_before_attribute_seperator"]}#{@source.key_str.strip}#{template_objects["template_values"]["char_after_attribute_seperator"]}"
    else
      string = @source.key_str
    end
    span_tag string, @source.attribute_color?
  end


  def value
    @source.value_str
  end
end