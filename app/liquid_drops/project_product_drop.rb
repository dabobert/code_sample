class ProjectProductDrop < DpLiquidDrop
  APPROVALS = %i(site_measure shop_drawings finish_sample cfa prototype seaming_diagram strike_off flame_certificate)

  def brand_name_label
    span_tag template_values["brand_name_caption"], @source.brand_name_color?
  end


  def brand_name
    string = @source.brand_name

    if self.is_nested? && template_objects["treat_nested_as_normal"].blank?
      string = "by #{string}"
    end

    if template_values["max_chars"].present?
      string = truncate(string, :length => template_values["max_chars"], :separator => /\w/, :omission => '...')
    end

    span_tag string, @source.brand_name_color?
  end


  def name_label
    span_tag template_values["product_name_caption"], @source.product_name_color?
  end


  def name
    if template_values["max_chars"].present?
      string = truncate(@source.name, :length => template_values["max_chars"], :separator => /\w/, :omission => '...')
    else
      @source.name
    end

    "<span class=\"#{@source.product_name_color? ? "marked_red" : ""}\">#{@source.name}</span>"
  end


  def code_label
    span_tag template_values["code_caption"], @source.product_name_color?
  end


  def code
    if @source.code.present_as_string?
      "<span class=\"#{@source.product_name_color? ? "marked_red" : ""}\">#{@source.code}</span>"
    end
  end

  def description_label
    "<span class=\"#{@source.description_color? ? "marked_red" : ""}\">Description</span>"
  end

  def description
    if @source.description.present_as_string?
      span_tag @source.descriptions.html_safe, @source.description_color?
    end
  end

  def notes_label
    span_tag "Notes:", @source.notes_color?
  end

  def notes
    if @source.notes.present_as_string?
      span_tag @source.notes.gsub(/(?:\n\r?|\r\n?)/, '<br>').html_safe, @source.notes_color?
    end
  end

  def general_notes
    if @source.general_notes.present_as_string?
      @source.general_notes.gsub(/(?:\n\r?|\r\n?)/, '<br>').html_safe
    end
  end

  def is_nested
    self.is_nested?
  end

  def is_nested?
    @source.ancestry.present?
  end

  def cost_unit
    if @source.cost_unit.present? && @source.cost_unit.to_f > 0 && template_values["export_cost_unit"]
      format_cost_unit(@source.cost_unit)
    end
  end


  def parent_total_qty
    "FIX cost_unit "
    # @parent_total_qty ||= 1
  end


  def product_total
    self.parent_total_qty * self.user_nested_qty
  end

  def rooms
    @rooms ||= (
      if @source.room_project_products.present?
        @source.room_project_products.order_attribute.collect{|x| ProjectProductRoomDrop.new(x)}
      end
    )
  end

  # def total_rooms_qty
  #   nil_or_integer_value @source.total_rooms_qty
  # end

  def custom_attributes
    @custom_attributes ||= (
      if @source.custom_specifications.present?
        @source.custom_specifications.collect{|x| CustomSpecificationDrop.new(x)}
      end
    )
  end

  def sales_rep
    @sales_rep ||= (
      if @source.sales_rep_id.present? && (sales_rep_obj = SalesRep.unscoped.find(@source.sales_rep_id)).present?
        SalesRepDrop.new(sales_rep_obj, "marked_red" => @source.sales_rep_color?)
      end
    )
  end

  def has_approvals
    APPROVALS.any? do |approval|
      @source.send(approval)
    end
  end

  APPROVALS.each do |attribute|
    #defines boolean function
    define_method attribute do
      @source.send(attribute)
    end

    #defines checkbox helper
    define_method "#{attribute}_checkbox" do
      checkbox_helper @source.send(attribute)
    end
  end

  def nested_products
    @nested_products ||= (
      if @source.descendants.present?
        @source.descendants.collect{|x| ProjectProductDrop.new(x)}
      end
    )
    
  end

  def nested_image
    image_tag @source.safe_default_image.s3_url(template_values["nested_image_size"]), :class => template_values["nested_image_class"]
  end

  def image_detail_1
    image_detail(1)
  end

  def image_detail_2
    image_detail(2)
  end

  def image_detail(num)
    image_path = @source.send("image_detail_#{num}").try(:s3_url)
    if image_path.present?
      image_markup = image_tag image_path, :width => template_values["image_detail_width"], height: template_values["image_detail_height"]
      "<span style=\"width: #{template_values["image_detail_width"]}\">#{image_markup}</span>"
    else
      "<span></span>"
    end
  end

  def image_caption
    span_tag @source.image_caption, @source.image_caption_color?
  end

  def image
    x = @options["product_image_width"].to_i
    y = @options["product_image_height"].to_i
    h,w = ApplicationController.helpers.get_best_size(@source,x,y)
    if @source.bw_image == true
      "<svg width=\"#{ w.to_i }\" height=\"#{ h.to_i }\" viewBox=\"0 0 0 0\"><defs><filter id=\"filter\" ><feColorMatrix id=\"gray\" type=\"saturate\" values=\"0.1\"/></filter></defs><image x=\"0\" y=\"0\" width=\"#{ w }\" height=\"#{ h }\" filter=\"url(#filter)\" xlink:href=\"#{ @source.image.original_image_url }\"/></svg>"
    else
      image = @source.image || @source.safe_default_image
      max_width = x
      if image.width > max_width
        scale = max_width/(image.width.to_f)
      else
        scale = 1
      end
      image_tag(image.filename.to_s, :class => 'thumb', :height => (image.height * scale).to_i, :width => (image.width * scale).to_i)
    end
  end

end