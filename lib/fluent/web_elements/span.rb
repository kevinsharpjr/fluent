module Fluent
  module WebElements
    class Span < WebElement

      def initialize(web_element, platform)
        @web_element = web_element
        include_platform_specifics_for platform
      end

      def include_platform_specifics_for(platform)
        super
      end

    end

    ::Fluent::WebElements.class_for_tag[:span] = ::Fluent::WebElements::Span
    
  end
end