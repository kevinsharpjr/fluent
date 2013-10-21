module Fluent
  module WebElements
    class TextField < WebElement

      def initialize(web_element, platform)
        @web_element = web_element
        include_platform_specifics_for platform
      end
      
      def append(text)
        web_element.send_keys(text)
      end

      def include_platform_specifics_for(platform)
        super
        if platform[:platform] == :watir_webdriver
          require 'fluent/platform_watir/platform_web_elements/text_field'
          self.class.send :include, Fluent::Platforms::WatirWebDriver::TextField
        end
      end

    end
  end
end