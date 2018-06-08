class DpLiquidDrop < Liquid::Drop
  include ActionView::Helpers::AssetTagHelper
  include ActionView::Helpers::NumberHelper
  include ActionView::Helpers::TextHelper
  include Firm::TemplatesHelper

  attr_reader :source, :options

  def initialize(source, options={})
    unless self.class.name == "#{source.class.name}Drop" || ["ProjectProductRoom"].exclude?(source.class.name)
      raise ArgumentError, "Expected #{self.class.name.gsub("Drop","")} but provided #{source.class.name}" 
    end

    @source   = source
    @options  = options
  end

  # make it easy to access global values passed into templates
  def template_objects
    @context.environments[0]
  end

  def template_values
    template_objects["template_values"]
  end

  def span_tag(inner_html, boolean)
    "<span class=\"#{boolean ? "marked_red" : ""}\">#{inner_html}</span>"
  end

  def nil_or_integer_value(value)
    if value.to_i > 0
      value
    else
      nil
    end
  end

  def nil_or_string_value(value)
    if value.to_s.strip.present?
      value
    else
      nil
    end
  end

  def checkbox_helper(boolean)
    if boolean
      "[x]"
    else
      "[ ]"
    end
  end


  def break
    binding.pry
  end

  # used within templates
  def [](method)
    if self.respond_to? method
      return self.send(method)
    elsif @source.respond_to? method
      # if the method is a column of type integer
      if @source.column_for_attribute(method).try(:type) == :integer
        # return nil if the integer value is 0
        return nil_or_integer_value(@source.send(method))
      else
        # return actual value
        return @source.send(method)
      end
    else
      super
    end
  end


  # used within ruby code like in attribute_row.rb
  def method_missing(method, *args)
    method = method.to_sym
    #sometimes @attr is nil, *shrug*
    if @source.respond_to? method
      return @source.send(method)
    else
      super
    end
  end

end