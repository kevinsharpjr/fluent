module Fluent
  module Platforms
    module WatirWebDriver
      module TextField

        def value
          web_element.value
        end
        
        def value=(text)
          web_element.set(text)
        end
        
      end
    end
  end
end