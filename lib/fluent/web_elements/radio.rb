module Fluent
  module WebElements
    class Radio < WebElement

      def initialize(web_element, platform)
        @web_element = web_element
        include_platform_specifics_for platform
      end

      def include_platform_specifics_for(platform)
        super
        if platform[:platform] == :watir_webdriver
          require 'fluent/platform_watir/platform_web_elements/radio'
          self.class.send :include, Fluent::Platforms::WatirWebDriver::Radio
        end
      end
      
    end

    ::Fluent::WebElements.class_for_type[:radio] = ::Fluent::WebElements::Radio
  end
end