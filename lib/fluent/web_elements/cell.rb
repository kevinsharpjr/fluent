module Fluent
  module WebElements
    class Cell < WebElement

      def initialize(web_element, platform)
        @web_element = web_element
        include_platform_specifics_for platform
      end

      def include_platform_specifics_for(platform)
        super
      end

    end

    ::Fluent::WebElements.class_for_tag[:td] = ::Fluent::WebElements::Cell
    ::Fluent::WebElements.class_for_tag[:th] = ::Fluent::WebElements::Cell
  end
end