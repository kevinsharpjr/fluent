module Fluent
  module Platforms
    module WatirWebDriver
      module WebElement

        def text
          @web_element.text
        end

        def exists?
          @web_element.exists?
        end

        def visible?
          @web_element.present?
        end
        
      end
    end
  end
end