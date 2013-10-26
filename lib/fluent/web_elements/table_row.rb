module Fluent
  module WebElements
    class TableRow < WebElement
      include Enumerable
      
      def initialize(web_element, platform)
        @web_element = web_element
        include_platform_specifics_for platform
      end

      # @return [Fluent::WebElements::Cell]
      def each
        for index in 1..self.columns do
          yield self[index - 1]
        end
      end

      def initialize_cell(row_element, platform)
        ::Fluent::WebElements::Cell.new(row_element, platform)
      end
      
      def cell_xpath
        './/child::td|th'
      end
      
      def include_platform_specifics_for(platform)
        super
        if platform[:platform] == :watir_webdriver
          require 'fluent/platform_watir/platform_web_elements/table_row'
          self.class.send :include, Fluent::Platforms::WatirWebDriver::TableRow
        end
      end

    end

    ::Fluent::WebElements.class_for_tag[:tr] = ::Fluent::WebElements::TableRow
  end
end