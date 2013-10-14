module Fluent
  module WebElements
    class Link
      
      def initialize(web_element)
        @web_element = web_element        
      end
      
      def text
        @web_element.text
      end
      
      def exists?
        @web_element.exists?
      end
      
      def visible?
        @web_element.present?
      end
      
    end
  end
end