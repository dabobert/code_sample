class Now < Liquid::Tag
  def initialize(tag_name, max, tokens)
    super
  end

  def render(context)
    Time.now.strftime("%m/%d/%Y")
  end
end