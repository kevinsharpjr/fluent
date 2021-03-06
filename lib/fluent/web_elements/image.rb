module Fluent
  module WebElements
    class Image < WebElement

      def initialize(web_element, platform)
        @web_element = web_element
        include_platform_specifics_for platform
      end

      def include_platform_specifics_for(platform)
        super
        if platform[:platform] == :watir_webdriver
          require 'fluent/platform_watir/platform_web_elements/image'
          self.class.send :include, Fluent::Platforms::WatirWebDriver::Image
        end
      end

    end

    ::Fluent::WebElements.class_for_tag[:img] = ::Fluent::WebElements::Image
  end
end