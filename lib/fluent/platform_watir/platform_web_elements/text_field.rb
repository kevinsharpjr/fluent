module Fluent
  module Platforms
    module WatirWebDriver
      module TextField
        
        def value=(text)
          web_element.set(text)
        end
        
      end
    end
  end
end