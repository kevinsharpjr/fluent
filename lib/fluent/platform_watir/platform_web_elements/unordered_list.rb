module Fluent
  module Platforms
    module WatirWebDriver
      module UnorderedList

        # @return [Fluent::WebElements::ListItem]
        def [](index)
          ::Fluent::WebElements::ListItem.new(children[index], :platform => :watir_webdriver)
        end

        def list_items
          web_element.uls(:xpath => list_item_xpath)
        end

        def children
          list_items.find_all { |item| item.parent == web_element }
        end

        def items
          children.size
        end
        
      end
    end
  end
end