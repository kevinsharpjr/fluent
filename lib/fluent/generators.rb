module Fluent
  module Generators
    
    def url_is(url=nil)
      msg = "The url_is assertion is empty on the definition #{self}."
      raise Fluent::Errors::NoUrlForDefinition, msg if url.nil?
      
      define_method('view') do
        platform.visit(url)
      end
    end
    
    def title_is(title=nil)
      msg = "The title_is assertion is empty on the definition #{self}."
      raise Fluent::Errors::NoTitleForDefinition, msg if title.nil?
      
      define_method('check_title') do
        msg  = "Expected title: '#{title}'; Actual title: '#{browser.title}'"
        valid_title = title == browser.title if title.kind_of?(String)
        valid_title = title =~ browser.title if title.kind_of?(Regexp)
        raise Fluent::Errors::TitleNotMatched, msg unless valid_title
        valid_title
      end
    end

    def look_for(widget, timeout=::Fluent.element_level_wait)
      define_method('check_objects') do
        if self.respond_to? "#{widget}_object"
          self.send("#{widget}_object").when_present(timeout)
        else
          raise "\n\nThe '#{widget}' object was not declared and could not be checked."
        end
      end
    end
    
    # This is required to allow declaring element definitions as being
    # within a frame in a page definition. The logic here makes sure that
    # the enclosed element definitions have their actions generated.
    def within_frame(locator, &block)
      frame = []
      frame << locator
      block.call(frame)
    end
    
    def link(identifier, locator)
      define_method(identifier) do
        return platform.link_click(locator.clone)
      end
      
      common_definition_methods(identifier, locator, __method__)
      common_definition_methods(identifier, locator, 'a')
    end
    
    def paragraph(identifier, locator)
      define_method(identifier) do
        return platform.paragraph_text(locator.clone)
      end
      
      common_definition_methods(identifier, locator, __method__)
      common_definition_methods(identifier, locator, 'p')
    end
    
    def div(identifier, locator)
      define_method(identifier) do
        return platform.div_text(locator.clone)
      end
      
      common_definition_methods(identifier, locator, __method__)
    end
    
    def span(identifier, locator)
      define_method(identifier) do
        return platform.span_text(locator.clone)
      end
      
      common_definition_methods(identifier, locator, __method__)
    end
    
    def button(identifier, locator)
      define_method(identifier) do
        return platform.button_click(locator.clone)
      end
      
      common_definition_methods(identifier, locator, __method__)
    end
    
    def text_field(identifier, locator)
      define_method(identifier) do
        return platform.text_field_get(locator.clone)
      end
      
      define_method("#{identifier}=") do |value|
        return platform.text_field_set(locator.clone, value)
      end
      
      common_definition_methods(identifier, locator, __method__)
      common_definition_methods(identifier, locator, 'textfield')
    end
    
    def text_area(identifier, locator)
      define_method(identifier) do
        return platform.text_area_get(locator.clone)
      end

      define_method("#{identifier}=") do |value|
        return platform.text_area_set(locator.clone, value)
      end
      
      common_definition_methods(identifier, locator, __method__)
      common_definition_methods(identifier, locator, 'textarea')
    end
    
    def checkbox(identifier, locator)
      define_method("#{identifier}_checked?") do
        return platform.checkbox_check_state(locator.clone)
      end

      define_method("check_#{identifier}") do
        return platform.checkbox_check(locator.clone)
      end

      define_method("uncheck_#{identifier}") do
        return platform.checkbox_uncheck(locator.clone)
      end
      
      common_definition_methods(identifier, locator, __method__)
    end
    
    def select_list(identifier, locator)
      define_method(identifier) do
        return platform.select_list_get_selected(locator.clone)
      end

      alias_method "#{identifier}_option?".to_sym, "#{identifier}".to_sym
      
      define_method("#{identifier}=") do |value|
        return platform.select_list_set(locator.clone, value)
      end

      define_method("#{identifier}_options?") do
        web_object = self.send("#{identifier}_object")
        (web_object && web_object.options) ? web_object.options.collect(&:text) : []
      end

      define_method("#{identifier}_value?") do
        return platform.select_list_get_value(locator.clone)
      end
      
      common_definition_methods(identifier, locator, __method__)
    end
    
    def radio(identifier, locator)
      define_method("select_#{identifier}") do
        return platform.radio_select(locator.clone)
      end

      define_method("#{identifier}_selected?") do
        return platform.radio_check_state(locator.clone)
      end

      alias_method "#{identifier}_set?".to_sym, "#{identifier}_selected?".to_sym
      alias_method "set_#{identifier}".to_sym, "select_#{identifier}".to_sym
      
      common_definition_methods(identifier, locator, __method__)
      common_definition_methods(identifier, locator, 'radio_button')
    end
    
    def ordered_list(identifier, locator)
      define_method(identifier) do
        return platform.ordered_list_text(locator.clone)
      end
      
      common_definition_methods(identifier, locator, __method__)
      common_definition_methods(identifier, locator, 'ol')
    end

    def unordered_list(identifier, locator)
      define_method(identifier) do
        return platform.unordered_list_text(locator.clone)
      end

      common_definition_methods(identifier, locator, __method__)
      common_definition_methods(identifier, locator, 'ul')
    end
    
    def list_item(identifier, locator)
      define_method(identifier) do
        return platform.list_item_text(locator.clone)
      end
      
      common_definition_methods(identifier, locator, __method__)
      common_definition_methods(identifier, locator, 'li')
    end
    
    def table(identifier, locator)
      define_method(identifier) do
        return platform.table_text(locator.clone)
      end
      
      common_definition_methods(identifier, locator, __method__)
    end

    def cell(identifier, locator)
      define_method(identifier) do
        return platform.cell_text(locator.clone)
      end

      common_definition_methods(identifier, locator, __method__)
      common_definition_methods(identifier, locator, 'td')
    end
    
    def label(identifier, locator)
      define_method(identifier) do
        return platform.label_text(locator.clone)
      end

      common_definition_methods(identifier, locator, __method__)
    end
    
    def hidden(identifier, locator)
      define_method(identifier) do
        return platform.hidden_value(locator.clone)
      end

      common_definition_methods(identifier, locator, __method__)
    end
    
    alias_method :radio_button, :radio
    alias_method :textarea, :text_area
    alias_method :textfield, :text_field
    alias_method :a, :link
    alias_method :p, :paragraph
    alias_method :ol, :ordered_list
    alias_method :ul, :unordered_list
    alias_method :li, :list_item
    alias_method :td, :cell
    
    def common_definition_methods(identifier, locator, method)
      define_method("#{identifier}_object") do
        platform.send(method, locator.clone)
      end
      
      define_method("#{identifier}_exists?") do
        platform.send(method, locator.clone).exists?
      end

      define_method("#{identifier}_visible?") do
        platform.send(method, locator.clone).visible?
      end
            
      alias_method "#{identifier}_#{method}".to_sym, "#{identifier}_object".to_sym
      alias_method "#{identifier}_element".to_sym, "#{identifier}_object".to_sym

      alias_method "#{identifier}?".to_sym, "#{identifier}_exists?".to_sym
      alias_method "#{identifier}_?".to_sym, "#{identifier}_visible?".to_sym
      
      alias_method "#{identifier}_#{method}_exists?".to_sym, "#{identifier}_exists?".to_sym
      alias_method "#{identifier}_#{method}_visible?".to_sym, "#{identifier}_visible?".to_sym
      
      alias_method "#{identifier}_#{method}?".to_sym, "#{identifier}_exists?".to_sym
      alias_method "#{identifier}_#{method}_?".to_sym, "#{identifier}_visible?".to_sym
      
      if Fluent.can_be_enabled?(method)
        define_method("#{identifier}_enabled?") do
          platform.send(method, locator.clone).enabled?
        end

        alias_method "#{identifier}!".to_sym, "#{identifier}_enabled?".to_sym
        alias_method "#{identifier}_#{method}_enabled?".to_sym, "#{identifier}_enabled?".to_sym
        alias_method "#{identifier}_#{method}!".to_sym, "#{identifier}_exists?".to_sym
      end
    end
    
  end
end