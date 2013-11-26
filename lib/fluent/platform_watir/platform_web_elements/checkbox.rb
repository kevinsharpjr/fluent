module Fluent
  module Platforms
    module WatirWebDriver
      module CheckBox
        
        def checked?
          web_element.set?
        end
        
        alias_method :set?, :checked?
        
        def check
          web_element.set
        end
        
        def set(state=true)
          web_element.set if state
          web_element.clear unless state
        end
        
        def uncheck
          web_element.clear
        end
        
      end
    end
  end
end