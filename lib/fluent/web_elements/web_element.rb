module Fluent
  module WebElements
    class WebElement
      
      def include_platform_specifics_for(platform)
        if platform[:platform] == :watir_webdriver
          require 'fluent/platform_watir/platform_web_elements/web_element'
          self.class.send :include, ::Fluent::Platforms::WatirWebDriver::WebElement
        end
      end
      
    end
  end
end