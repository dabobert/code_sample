class StatusRow < DpLiquidBlock

  def render(context)
    objects    = context.environments[0]
    collection = context.evaluate(@collection_name) or return ''.freeze

    from = @attributes.key?('offset'.freeze) ? context.evaluate(@attributes['offset'.freeze]).to_i : 0
    to = @attributes.key?('limit'.freeze) ? from + context.evaluate(@attributes['limit'.freeze]).to_i : nil

    collection =  Liquid::Utils.slice_collection(collection, from, to)

    length = collection.length

    cols = context.evaluate(@attributes['cols'.freeze]).to_i

    result = "<div>\n"
    context.stack do
      # binding.pry
      # tablerowloop = TablerowloopDrop.new(length, cols)
      # context['tablerowloop'.freeze] = tablerowloop

      collection.each_with_index do |item,index|
        # skip the attribute sometimes
        next if objects["project_product"].source.project.export_hide_blank_attributes? && item.source.is_divider? == false && item.value.blank?

        context[@variable_name] = item

        # short circuit if max is exceeded
        break if @attributes["max"].present? && index > @attributes["max"]

        result << super

        #skip seperator at the end
        # result << @attributes["seperator"] unless index + 1 == collection.size

        # if tablerowloop.col_last && !tablerowloop.last
        #   result << "</div>\n<div class=\"row#{tablerowloop.row + 1}\">"
        # end

        # tablerowloop.send(:increment!)
      end
    end
    result << "</div>\n"
    # binding.pry
    result
  end

end