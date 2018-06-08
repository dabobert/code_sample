class FirmDrop < DpLiquidDrop

  # def logo
  #   image_size = @source.show_horizontal_logo ? [width: "180px", height: "32px"] : [width: "60px", height: "60px"]
  #   if @source.logo.present? && !@source.hide_firm_logo
  #     image = image_tag(@source.logo.try(@source.show_horizontal_logo ? :horizontal : :sq64).try(:url), *image_size) 
  #     content_tag(:div, image, :class => "firm_logo")
  #   end
  # end


  def logo
    # binding.pry
    max_width   = template_values["firm_logo_width"].to_i
    max_height  = template_values["firm_logo_height"].to_i
    # h,w = ApplicationController.helpers.get_best_size(@source,x,y)



    #dimensions of log is 128 by 128
    image_url = @source.logo.try(:sq128).try(:url)
    image_width  = 128
    image_height = 128


    if image_width > max_width
      scale = max_width/(image_width.to_f)
    else
      scale = 1
    end
    image_html = image_tag(image_url, :height => (image_height * scale).to_i, :width => (image_width * scale).to_i)
    content_tag(:div, image_html, :class => "firm_logo")
  end
end