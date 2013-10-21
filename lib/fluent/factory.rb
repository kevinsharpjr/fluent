module Fluent
  module Factory

    # Creates a definition context for actions.
    #
    # @param definition [Class] the name of a definition class
    # @param block [Proc] logic to execute within the context of the definition
    # @return [Object] instance of the definition
    def on(definition, visit=false, &block)
      return @active if @active.kind_of?(definition)
      @active = definition.new(@browser, visit)
      block.call @active if block
      @active
    end

    alias_method :on_page, :on
    alias_method :while_on, :on

    # Creates a definition context for actions and establishes the
    # context for display.
    #
    # @param definition [Class] the name of a definition class
    # @param block [Proc] logic to execute within the context of the definition
    def on_view(definition, &block)
      on(definition, true, &block)
    end

    alias_method :on_visit, :on_view
    
  end
end