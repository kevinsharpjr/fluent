module Fluent
  module WebElements
    class OrderedList < WebElement
      include Enumerable
      
      def initialize(web_element, platform)
        @web_element = web_element
        include_platform_specifics_for platform
      end
      
      # @return [Fluent::WebElements::ListItem]
      def each
        for index in 1..self.items do
          yield self[index - 1]
        end
      end

      def list_item_xpath
        './/child::li'
      end
      
      def include_platform_specifics_for(platform)
        super
        if platform[:platform] == :watir_webdriver
          require 'fluent/platform_watir/platform_web_elements/ordered_list'
          self.class.send :include, Fluent::Platforms::WatirWebDriver::OrderedList
        end
      end

    end

    ::Fluent::WebElements.class_for_tag[:ol] = ::Fluent::WebElements::OrderedList
  end
end