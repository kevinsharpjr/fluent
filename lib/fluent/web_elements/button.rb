module Fluent
  module WebElements
    class Button < WebElement

      def initialize(web_element, platform)
        @web_element = web_element
        include_platform_specifics_for platform
      end

      def include_platform_specifics_for(platform)
        super
      end
      
    end

    ::Fluent::WebElements.class_for_type[:submit] = ::Fluent::WebElements::Button
    ::Fluent::WebElements.class_for_type[:button] = ::Fluent::WebElements::Button
    ::Fluent::WebElements.class_for_type[:image]  = ::Fluent::WebElements::Button
    ::Fluent::WebElements.class_for_type[:reset]  = ::Fluent::WebElements::Button
  end
end