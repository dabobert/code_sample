class ProductDrop < DpLiquidDrop





def foo
  "bar"
end
 
#  def context
# binding.pry
#     @context ||= Context.new(self)
#   end

# def render(data = template, ctx = {})
#   binding.pry
# end

  def name
    "yellow"
  end

  #bit of ruby metaprogramming for the presenter to check attrs for missing methods
  def method_missing(method, *args)
    binding.pry
    method = method.to_sym
    #sometimes @attr is nil, *shrug*
    if @source.respond_to? method
      return @source.send(method)
    else
      super
    end
  end



end