module Fluent
  module Platforms
    module WatirWebDriver
      module Radio

        def selected?
          web_element.set?
        end

        alias_method :set?, :selected?
        
        def select
          web_element.set
        end

        def clear
          web_element.clear
        end
        
      end
    end
  end
end