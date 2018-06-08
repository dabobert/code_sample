module Firm::TemplatesHelper


  ###### used by action form

  def firm_template_path_hash(record)
    if record.new_record?
      { :controller => "firm/templates", :action => :create }
    else
      { :controller => "firm/templates", :action => :update }
    end
  end

  ###### used by templates

  def format_cost_unit(value)
    number_with_precision(value, :precision => 2)
  end

  def firm_logo
    image_size = @firm.show_horizontal_logo ? [width: "180px", height: "32px"] : [width: "60px", height: "60px"]
    if @firm.logo.present? && !@firm.hide_firm_logo
      image = image_tag(@firm.logo.try(@firm.show_horizontal_logo ? :horizontal : :sq64).try(:url), *image_size) 
      content_tag(:div, image, :class => "firm_logo")
    end
  end

  def html_line_break
    content_tag(:hr, nil, :class => "page_break")
  end

  def office_logo
    image_size = @firm.show_horizontal_logo ? [width: "180px", height: "32px"] : [width: "60px", height: "60px"]
    if @project.try(:office).try(:logo).present? && !@firm.hide_firm_logo
      image = image_tag(@project.try(:office).try(:logo).try(@firm.show_horizontal_logo ? :horizontal : :sq128 ).try(:url))
      content_tag(:div, image, :class => "office_logo")
    end
  end

  def content_viewport(&block)
    if @format == :html
      if @export.landscape_orienation?
        content_tag(:div, capture(&block), :class => "landscape_viewport")
      else
        content_tag(:div, capture(&block), :class => "portrait_viewport")
      end
    else
      raw "<span>#{capture(&block)}</span>"
    end
  end

  def optional_page_break(boolean, &block)
    if boolean
      header = render_header_for_html_preview
      footer = ""#"<div><h1>--</h1></div>"#render_footer_for_html_preview
      raw "<div class=\"page page_break_b #{@format}\" style=\"clear: both\">\n#{header}\n#{capture(&block)}\n#{footer}\n</div>"
    else
      raw "<span>#{capture(&block)}</span>"
    end
  end

  def span_with_optional_classes(boolean, css, &block)
    raw "<span class=\"#{boolean ? css : nil}\">#{capture(&block)}</span>"
  end

  def render_header_for_html_preview(boolean=true)
    if boolean && @format == :html && @debug.present?
      raw "<!-- header (Debugging) -->\n#{Liquid::Template.parse(@export.header).render(header_footer_objects)}"
    end  
  end

  def render_footer_for_html_preview(boolean=true)
    if boolean && @format == :html && @debug.present? 
      raw "<!-- footer (Debugging) -->\n#{Liquid::Template.parse(@export.footer).render(header_footer_objects)}"
    end  
  end


  ###### wrappers

  def header_footer_objects
    {
      "project" => ProjectDrop.new(@project, @export.values),
      "office" => OfficeDrop.new(@office),
      "firm" => FirmDrop.new(@firm),
      "firm_logo" => firm_logo,
      "template_values" => template_values
    }
  end

  def body_objects(project_product)
    header_footer_objects.merge("project_product" => ProjectProductDrop.new(project_product, @export.values))
  end

  def template_values
    @export.template_settings.merge(@project.template_settings)
  end

  ###### test code

  def test_render
    template = Liquid::Template.parse "{% firm_logo %} --  <h1>{{ product.id }} {{ product.name }} {{ product.manufacturer_id }} {{ product.foo }} {{ product.bar }}</h1>"
    template.assigns['product'] = ProductDrop.new(Product.first) # Please note the hash assignment is a string, not a symbol
    # template.assigns['collections'] = CollectionDrop.new(@product.collections)
    template.render
  end



  ###### migrated from old code

  def get_best_size(project_product, maxWidth, maxHeight, set_margins=true)
    #maxWidth = max width of the container
    #maxHeight = max height of container
    image = project_product.image || project_product.safe_default_image

    width       = image.width # Current image width
    height      = image.height # Current image height
    margin_top  = ""
    margin_left = ""

    # Check if the current width is larger than the max
    if width > maxWidth && width > height
      ratio  = maxWidth / width.to_f # get ratio for scaling image
      width  = maxWidth
      height = (height * ratio).round # Reset height to match scaled image
      margin_top = (maxHeight - height) / 2
    elsif height > maxHeight && height > width 
      ratio  = maxHeight / height.to_f # get ratio for scaling image
      height = maxHeight # Set new height
      width  = (width * ratio).round # Scale width based on ratio
      margin_left = (maxWidth - width) / 2
    elsif width > maxWidth
      ratio  = maxWidth / width.to_f # get ratio for scaling image
      width  = maxWidth
      height = (height * ratio).round # Reset height to match scaled image
      margin_top = (maxHeight - height) / 2
    elsif height > maxHeight
      ratio  = maxHeight / height.to_f # get ratio for scaling image
      height = maxHeight # Set new height
      width  = (width * ratio).round # Scale width based on ratio
      margin_left = (maxWidth - width) / 2
    else
      margin_top = (maxHeight - height) / 2
      margin_left = (maxWidth - width) / 2
    end

    unless set_margins
      margin_top = 0
      margin_left = 0
    end
    
    #return the best height and width of the image based on the container max values
    return height, width
  end



end
