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
        
      end
    end
  end
end