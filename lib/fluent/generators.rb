module Fluent
  module Generators
    
    def url_is(url=nil)
      msg = "The url_is assertion is empty on the definition #{self}."
      raise Fluent::Errors::NoUrlForDefinition, msg if url.nil?
      
      define_method('view') do
        platform.visit(url)
      end
      
      define_method('check_url') do
        msg  = "Expected url: '#{url}'; Actual url: '#{driver.url}'"
        valid_url = url == driver.url
        raise Fluent::Errors::UrlNotMatched, msg unless valid_url
      end
    end
    
    def title_is(title=nil)
      msg = "The title_is assertion is empty on the definition #{self}."
      raise Fluent::Errors::NoTitleForDefinition, msg if title.nil?
      
      define_method('check_title') do
        msg  = "Expected title: '#{title}'; Actual title: '#{driver.title}'"
        valid_title = title == driver.title if title.kind_of?(String)
        valid_title = title =~ driver.title if title.kind_of?(Regexp)
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
      
      alias_method "#{identifier}_get".to_sym, "#{identifier}".to_sym
      
      define_method("#{identifier}=") do |value|
        return platform.text_field_set(locator.clone, value)
      end
      
      alias_method "#{identifier}_set", "#{identifier}=".to_sym
      
      common_definition_methods(identifier, locator, __method__)
      common_definition_methods(identifier, locator, 'textfield')
    end
    
    def text_area(identifier, locator)
      define_method(identifier) do
        return platform.text_area_get(locator.clone)
      end

      alias_method "#{identifier}_get".to_sym, "#{identifier}".to_sym
      
      define_method("#{identifier}=") do |value|
        return platform.text_area_set(locator.clone, value)
      end

      alias_method "#{identifier}_set", "#{identifier}=".to_sym
      
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
      
      alias_method "#{identifier}_check".to_sym, "check_#{identifier}".to_sym
      
      define_method("uncheck_#{identifier}") do
        return platform.checkbox_uncheck(locator.clone)
      end

      alias_method "#{identifier}_uncheck".to_sym, "uncheck_#{identifier}".to_sym
      
      common_definition_methods(identifier, locator, __method__)
    end
    
    def select_list(identifier, locator)
      define_method(identifier) do
        return platform.select_list_get_selected(locator.clone)
      end

      alias_method "#{identifier}_get".to_sym, "#{identifier}".to_sym
      alias_method "#{identifier}_option?".to_sym, "#{identifier}".to_sym
      
      define_method("#{identifier}_set") do |value|
        return platform.select_list_set(locator.clone, value)
      end
      
      alias_method "#{identifier}_select", "#{identifier}_set".to_sym
      
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
      define_method("set_#{identifier}") do
        return platform.radio_select(locator.clone)
      end

      alias_method "#{identifier}_set".to_sym, "set_#{identifier}".to_sym
      
      define_method("#{identifier}_set?") do
        return platform.radio_check_state(locator.clone)
      end
      
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
    
    def form(identifier, locator)
      common_definition_methods(identifier, locator, __method__)
    end
    
    def image(identifier, locator)
      define_method("#{identifier}_loaded?") do
        return platform.image_action(locator.clone, 'loaded?')
      end

      define_method("#{identifier}_height") do
        return platform.image_action(locator.clone, 'height')
      end

      define_method("#{identifier}_width") do
        return platform.image_action(locator.clone, 'width')
      end

      define_method("#{identifier}_dimensions") do
        return platform.image_get_dimensions(locator.clone)
      end

      define_method("#{identifier}_src") do
        return platform.image_get_source(locator.clone)
      end

      define_method("#{identifier}_alt") do
        return platform.image_get_alt_text(locator.clone)
      end
      
      common_definition_methods(identifier, locator, __method__)
      common_definition_methods(identifier, locator, 'img')
    end
    
    [:h1, :h2, :h3, :h4, :h5, :h6].each do |method|
      define_method(method) do |identifier, locator|
        define_method(identifier) do
          platform_method = "#{method.to_s}_text"
          return platform.send(platform_method, locator.clone)
        end
        
        common_definition_methods(identifier, locator, method)
      end
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
    alias_method :img, :image
    
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
      
      if Fluent.can_display_text?(method)
        define_method("#{identifier}_text") do
          platform.send(method, locator.clone).text
        end
      end
      
      if Fluent.can_be_enabled?(method)
        define_method("#{identifier}_enabled?") do
          platform.send(method, locator.clone).enabled?
        end

        alias_method "#{identifier}!".to_sym, "#{identifier}_enabled?".to_sym
        alias_method "#{identifier}_#{method}_enabled?".to_sym, "#{identifier}_enabled?".to_sym
        alias_method "#{identifier}_#{method}!".to_sym, "#{identifier}_exists?".to_sym
      end
    end
    
    ELEMENT_LIST = [:text_field, :text_area, :select_list, :checkbox, :radio,
                    :link, :button, :table, :cell, :div, :span, :image,
                    :list_item, :ordered_list, :unordered_list, :form,
                    :h1, :h2, :h3, :h4, :h5, :h6, :paragraph, :label, :hidden]
    
    def self.generate_locators(caller)
      ELEMENT_LIST.each do |element|
        caller.send(:define_method, "#{element.to_s}_locate") do |*locator|
          @platform.send "#{element.to_s}", locate_by(locator)
        end
        
        caller.send(:define_method, "#{element.to_s}_elements") do |*locator|
          @platform.send("#{element}s", locator[0] ? locator[0] : {})
        end
      end
    end
    
    element_set = ELEMENT_LIST.clone
    element_set[element_set.find_index(:checkbox)] = :checkboxe
    element_set.each do |selector|
      define_method("#{selector}s") do |identifier, *locator|
        define_method("#{identifier}_elements") do
          platform_method = "#{selector.to_s}s" unless selector == :checkboxe
          platform_method = "checkboxes" if selector == :checkboxe
          platform.send platform_method, (locator.first ? locator.first.clone : {})
        end
      end
    end
    
  end
end