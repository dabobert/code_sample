class CustomAttribute < Liquid::Block
  Syntax = /(\w+)\s+in\s+(#{Liquid::QuotedFragment}+)/o

  def initialize(tag_name, markup, options)
    super
    if markup =~ Syntax
      @variable_name = $1
      @collection_name = Liquid::Expression.parse($2)
      @attributes = {}
      markup.scan(Liquid::TagAttributes) do |key, value|
        @attributes[key] = Liquid::Expression.parse(value)
      end
      # binding.pry
    else
      raise SyntaxError.new(options[:locale].t("errors.syntax.table_row".freeze))
    end
  end

    def render(context)
      collection = context.evaluate(@collection_name) or return ''.freeze

      from = @attributes.key?('offset'.freeze) ? context.evaluate(@attributes['offset'.freeze]).to_i : 0
      to = @attributes.key?('limit'.freeze) ? from + context.evaluate(@attributes['limit'.freeze]).to_i : nil

      collection =  Liquid::Utils.slice_collection(collection, from, to)

      length = collection.length

      cols = context.evaluate(@attributes['cols'.freeze]).to_i

      result = "<div class=\"row1\">\n"
      context.stack do
        # binding.pry
        tablerowloop = TablerowloopDrop.new(length, cols)
        context['tablerowloop'.freeze] = tablerowloop

        collection.each do |item|
          context[@variable_name] = item

          result << "<strong class=\"col#{tablerowloop.col}\">" << super << '</strong>'

          if tablerowloop.col_last && !tablerowloop.last
            result << "</div>\n<div class=\"row#{tablerowloop.row + 1}\">"
          end

          tablerowloop.send(:increment!)
        end
      end
      result << "</div>\n"
      # binding.pry
      result
    end

end