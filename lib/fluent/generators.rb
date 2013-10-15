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
    
    def link(identifier, locator)
      define_method(identifier) do
        return platform.link_click(locator)
      end
      
      common_definition_methods(identifier, locator, __method__)
    end
    
    def paragraph(identifier, locator)
      define_method(identifier) do
        return platform.paragraph_text(locator)
      end
      
      common_definition_methods(identifier, locator, __method__)
    end
    
    def button(identifier, locator)
      define_method(identifier) do
        return platform.button_click(locator)
      end
      
      common_definition_methods(identifier, locator, __method__)
    end
    
    def common_definition_methods(identifier, locator, method)
      define_method("#{identifier}_object") do
        platform.send(method, locator)
      end
      
      define_method("#{identifier}_exists?") do
        platform.send(method, locator).exists?
      end

      define_method("#{identifier}_visible?") do
        platform.send(method, locator).visible?
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
          platform.send(method, locator).enabled?
        end

        alias_method "#{identifier}!".to_sym, "#{identifier}_enabled?".to_sym
        alias_method "#{identifier}_#{method}_enabled?".to_sym, "#{identifier}_enabled?".to_sym
        alias_method "#{identifier}_#{method}!".to_sym, "#{identifier}_exists?".to_sym
      end
    end
    
  end
end