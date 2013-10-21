module Fluent
  module Platforms
    module WatirWebDriver
      module CheckBox
        
        def checked?
          web_element.set?
        end
        
        def check
          web_element.set
        end
        
        def uncheck
          web_element.clear
        end
        
      end
    end
  end
end