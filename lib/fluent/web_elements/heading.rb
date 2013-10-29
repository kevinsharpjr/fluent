module Fluent
  module WebElements
    class Heading < WebElement

      def initialize(web_element, platform)
        @web_element = web_element
        include_platform_specifics_for platform
      end

      def include_platform_specifics_for(platform)
        super
      end

    end

    ::Fluent::WebElements.class_for_tag[:h1] = ::Fluent::WebElements::Heading
    ::Fluent::WebElements.class_for_tag[:h2] = ::Fluent::WebElements::Heading
    ::Fluent::WebElements.class_for_tag[:h3] = ::Fluent::WebElements::Heading
    ::Fluent::WebElements.class_for_tag[:h4] = ::Fluent::WebElements::Heading
    ::Fluent::WebElements.class_for_tag[:h5] = ::Fluent::WebElements::Heading
    ::Fluent::WebElements.class_for_tag[:h6] = ::Fluent::WebElements::Heading
  end
end