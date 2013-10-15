module Fluent
  module WebElements
    class WebElement
      
      attr_reader :web_element
      
      def initialize(web_element, platform)
        @web_element = web_element
        include_platform_specifics_for platform
      end
      
      def click
        web_element.click
      end
      
      def enabled?
        web_element.enabled?
      end
      
      def disabled?
        not enabled?
      end
      
      def include_platform_specifics_for(platform)
        if platform[:platform] == :watir_webdriver
          require 'fluent/platform_watir/platform_web_elements/web_element'
          self.class.send :include, ::Fluent::Platforms::WatirWebDriver::WebElement
        end
      end
      
    end
  end
end