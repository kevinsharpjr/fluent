require 'fluent/workflows'

module Fluent
  module Factory
    include Workflow
    
    # Creates a definition context for actions. If an existing context
    # exists, that context will be re-used.
    #
    # @param definition [Class] the name of a definition class
    # @param visit [Boolean] true if the context needs to be called into view
    # @param block [Proc] logic to execute within the context of the definition
    # @return [Object] instance of the definition
    def on(definition, visit=false, &block)
      definition = get_object_for(definition) if definition.is_a? String
      
      if @active.kind_of?(definition)
        block.call @active if block
        return @active
      end
      
      if @context.kind_of?(definition)
        block.call @context if block
        return @context
      end
         
      @active = definition.new(@driver, visit)
      block.call @active if block
      
      @active
    end

    alias_method :on_page, :on
    alias_method :while_on, :on
    
    # Creates a definition context for actions. Unlike the on() factory,
    # on_new will always create a new context and will never re-use an
    # existing one.
    #
    # @param definition [Class] the name of a definition class
    # @param visit [Boolean] true if the context needs to be called into view
    # @param block [Proc] logic to execute within the context of the definition
    # @return [Object] instance of the definition
    def on_new(definition, visit=false, &block)
      definition = get_object_for(definition) if definition.is_a? String

      if @context.kind_of?(definition)
        @context = nil
      end
  
      @active = definition.new(@driver, visit)
      block.call @active if block

      @active
    end
    
    # Creates a definition context for actions and establishes the
    # context for display.
    #
    # @param definition [Class] the name of a definition class
    # @param block [Proc] logic to execute within the context of the definition
    def on_view(definition, &block)
      on(definition, true, &block)
    end

    alias_method :on_visit, :on_view

    # Creates a definition context for actions. If an existing context
    # exists, that context will be re-used. This also sets a context that 
    # will be used for that definition even if the active definition changes
    #
    # @param definition [Class] the name of a definition class
    # @param visit [Boolean] true if the context needs to be called into view
    # @param block [Proc] logic to execute within the context of the definition
    # @return [Object] instance of the definition
    def on_set(definition, visit=false, &block)
      on(definition, visit, &block)
      @context = @active      
      @active
    end


    def get_object_for(definition)
      definition.split('::').inject(Object) do |obj, name|
        obj.const_get(name)
      end
    end
    
  end
end