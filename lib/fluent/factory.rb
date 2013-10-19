module Fluent
  module Factory
    
    def on(definition, visit=false, &block)
      return @active if @active.kind_of?(definition)
      @active = definition.new(@browser, visit)
      block.call @active if block
      @active
    end

    alias_method :on_page, :on
    alias_method :while_on, :on
    
    def on_view(definition, &block)
      on(definition, true, &block)
    end

    alias_method :on_visit, :on_view
    
  end
end