module Fluent
  module WebElements
    class Table < WebElement
      include Enumerable

      def initialize(web_element, platform)
        @web_element = web_element
        include_platform_specifics_for platform
      end

      # @return [Fluent::WebElements::TableRow]
      def each
        for index in 1..self.rows do
          yield self[index - 1]
        end
      end

      # @return [Fluent::WebElements::TableRow]
      def first_row
        self[0]
      end

      # @return [Fluent::WebElements::TableRow]
      def last_row
        self[-1]
      end

      def initialize_row(element, platform)
        ::Fluent::WebElements::TableRow.new(element, platform)
      end
      
      def row_xpath
        './/child::tr'
      end
      
      def include_platform_specifics_for(platform)
        super
        if platform[:platform] == :watir_webdriver
          require 'fluent/platform_watir/platform_web_elements/table'
          self.class.send :include, Fluent::Platforms::WatirWebDriver::Table
        end
      end

    end

    ::Fluent::WebElements.class_for_tag[:table] = ::Fluent::WebElements::Table
  end
end