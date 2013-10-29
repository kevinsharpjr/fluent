module Fluent
  module WebElements
    
    class << self
      def class_for_tag
        @class_for_tag ||= {}
      end
      
      def class_for_type
        @class_for_type ||= {}
      end
      
      def get_class_for(tag, type=nil)
        return class_for_type[type.to_sym] if type
        class_for_tag[tag.to_sym] || ::Fluent::WebElements::WebElement
      end
    end
    
  end
end