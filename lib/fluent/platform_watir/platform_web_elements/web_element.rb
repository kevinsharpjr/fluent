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
        
      end
    end
  end
end