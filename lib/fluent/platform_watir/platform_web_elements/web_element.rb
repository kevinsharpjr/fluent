module Fluent
  module Platforms
    module WatirWebDriver
      module WebElement
        
        def exists?
          web_element.exists?
        end

        def visible?
          web_element.present?
        end
        
        def double_click
          web_element.double_click
        end
        
        def clear
          web_element.clear
        end
        
        def flash(value=5)
          1.upto(value) { web_element.flash }
          web_element.exists?
        end

        def tag_name
          web_element.tag_name
        end

        def html
          web_element.html
        end
        
        def attribute(name)
          web_element.attribute_value(name)
        end

        def fire_event(event)
          web_element.fire_event(event)
        end

        def value
          web_element.value
        end
        
        def id
          web_element.id
        end

        def send_keys(*args)
          web_element.send_keys(*args)
        end

        def scroll_into_view
          web_element.wd.location_once_scrolled_into_view
        end
        
        def focus
          web_element.focus
        end

        def hover
          web_element.hover
        end

        def when_present(timeout=::Fluent.element_level_wait)
          web_element.wait_until_present(timeout)
          self
        end
        
        def when_not_present(timeout=::Fluent.element_level_wait)
          web_element.wait_while_present(timeout)
          self
        end

        def when_visible(timeout=::Fluent.element_level_wait)
          Object::Watir::Wait.until(timeout, "Object not visible within #{timeout} seconds.") do
            visible?
          end
          self
        end

        def when_not_visible(timeout=::Fluent.element_level_wait)
          Object::Watir::Wait.while(timeout, "Object still visible after #{timeout} seconds.") do
            visible?
          end
          self
        end

        def wait_until(timeout=::Fluent.element_level_wait, message=nil, &block)
          Object::Watir::Wait.until(timeout, message, &block)
        end
        
        alias_method :when_actionable, :when_present
        alias_method :when_not_actionable, :when_not_present
      end
    end
  end
end