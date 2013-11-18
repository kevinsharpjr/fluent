module Fluent
  module Platforms
    module WatirWebDriver
      module Image
        
        def width
          web_element.width
        end
        
        def height
          web_element.height
        end
        
        def loaded?
          web_element.loaded?
        end
        
      end
    end
  end
end