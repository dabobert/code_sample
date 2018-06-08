class ExportTemplate < ActiveRecord::Base
  BITFIELD_FIELDS = [:landscape_orienation,
                      :page_break_before_preface,
                      :page_break_before_body,
                      :page_break_before_postface,
                      :treat_nested_as_normal,
                      :include_cutsheets]
  acts_as_bitfield :settings, :fields => BITFIELD_FIELDS

  after_initialize :parse_json_values

  before_save :convert_blank_values_to_nil, :assign_json_values

  #values stored in json_values column
  DEFAULT_TEMPLATE_VALUES = {
    :product_image_height => 255,
    :product_image_width  => 255,
    :image_detail_height  => 176,
    :image_detail_width   => 176,
    :nested_image_size    => "medium",
    :nested_image_class   => nil,
    :max_chars            => nil,
    :brand_name_caption   => "Manufacturer",
    :product_name_caption => "Style/Series:",
    :code_caption         => "Code:",
    :char_before_attribute_seperator => nil,
    :char_after_attribute_seperator => nil,
    :margin_top           => nil,
    :margin_bottom        => nil,
    :firm_logo_height     => 75,
    :firm_logo_width      => 75
  }


  TEMPLATE_VALUES_ARRAY = DEFAULT_TEMPLATE_VALUES.keys
  
  attr_accessor *TEMPLATE_VALUES_ARRAY
  attr_reader :values


  validates_presence_of :name, :product_body, :flow_template_id


  belongs_to :firm
  belongs_to :last_editor, :class_name => "Designer", :foreign_key => :last_editor_id
  belongs_to :creator, :class_name => "Designer", :foreign_key => :creator_id
  belongs_to :flow_template, :class_name => "ExportFlowTemplate"

  def values=(values_hash)
    raise "input value is not a hash" unless values_hash.kind_of? Hash
    @values = values_hash
    self.json_values = values_hash.to_json
  end

  # 2 is the id of designerpages itself. Any template owned by designerpages is treated as a global template 
  def global?
    self.firm_id == 2
  end

  def owner_name
    if self.global?
      "Global"
    else
      self.firm.try(:name)
    end
  end

  def creator_firm
    if self.creator.try(:is_admin?)
      Firm.find(2)
    else
      self.creator.try(:firm)
    end
  end

  def last_editor_firm
    if self.last_editor.try(:is_admin?)
      Firm.find(2)
    else
      self.last_editor.try(:firm)
    end
  end

  def filename(string)
    name_array = []
    name_array << self.filename_prefix
    name_array << string
    name_array << self.filename_suffix
    "#{name_array.compact.join("_")} - #{self.name}"
  end

  def orientation
    if self.landscape_orienation?
      "Landscape"
    else
      "Portrait"
    end
  end

  def continous_flow?
    [
      :page_break_before_preface,
      :page_break_before_body,
      :page_break_before_postface
    ].all? do |method|
      self.send(method) == false
    end
  end

  def template_settings
    settings = self.values
    BITFIELD_FIELDS.each do |method|
      settings[method] = self.send(method)
    end
    settings
  end

  def content_flow
    @content_flow ||= self.flow_template.try(:content)
    if @content_flow.blank?
      raise "Export Flow Template's content column is empty"
    else
      @content_flow
    end
  end


  def self.editable_fields
    [ :cover_page, :header, :product_preface, :product_body, :product_postface, :footer, :final_page, :stylesheet, :javascript ]
  end

  def assign_json_values
    hash = TEMPLATE_VALUES_ARRAY.inject({}) do |obj, template_value|
      if self.send(template_value).present?
        obj[template_value] = self.send(template_value)
      else
        obj[template_value] = DEFAULT_TEMPLATE_VALUES[template_value]
      end
      obj
    end
    self.json_values = hash.to_json
  end

  ############################################################################
  private
  ########################################################################

  def parse_json_values
    @values = Hashie::Mash.new JSON.parse( self.json_values || "{}")
    TEMPLATE_VALUES_ARRAY.each do |template_value|
      self.send("#{template_value}=", @values[template_value]) if @values.keys.include?(template_value.to_s)
    end
  end

  def convert_blank_values_to_nil
    [ :cover_page, :header, :product_preface, :product_body, :product_postface, :footer, :final_page ].each do |field|
      self.send("#{field}=",nil) if self.send(field).to_s.strip.blank?
    end
  end

#   def method_missing(method, *args)
# binding.pry
#     if @values.keys
#       return @source.send(method)
#     else
#       super
#     end
  # end


end
