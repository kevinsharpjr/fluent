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
    end
    
    def paragraph(identifier, locator)
      define_method(identifier) do
        return platform.paragraph_text(locator.clone)
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
    end

    alias_method :radio_button, :radio
    
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