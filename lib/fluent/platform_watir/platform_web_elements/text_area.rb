module Fluent
  module Platforms
    module WatirWebDriver
      module TextArea

        def value
          web_element.value
        end
        
        def value=(value)
          web_element.set(value)
        end
        
        def clear
          web_element.wd.clear
        end
        
      end
    end
  end
end