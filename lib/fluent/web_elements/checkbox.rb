module Fluent
  module WebElements
    class CheckBox < WebElement

      def initialize(web_element, platform)
        @web_element = web_element
        include_platform_specifics_for platform
      end

      def include_platform_specifics_for(platform)
        super
        if platform[:platform] == :watir_webdriver
          require 'fluent/platform_watir/platform_web_elements/checkbox'
          self.class.send :include, Fluent::Platforms::WatirWebDriver::CheckBox
        end
      end

    end
  end
end