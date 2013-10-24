module Fluent
  module WebElements
    class SelectList < WebElement

      def initialize(web_element, platform)
        @web_element = web_element
        include_platform_specifics_for platform
      end

      def option_xpath
        './/child::option'
      end
      
      def include_platform_specifics_for(platform)
        super
        if platform[:platform] == :watir_webdriver
          require 'fluent/platform_watir/platform_web_elements/select_list'
          self.class.send :include, Fluent::Platforms::WatirWebDriver::SelectList
        end
      end

    end

    ::Fluent::WebElements.class_for_tag[:select] = ::Fluent::WebElements::SelectList
  end
end