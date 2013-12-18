module Fluent
  module Platforms
    module WatirWebDriver
      module SelectList
        
        def select(value)
          web_element.select(value)
        end

        def select_value(value)
          web_element.select_value(value)
        end

        def selected?(value)
          web_element.selected? value
        end
        
        # @return [Array] array of strings representing the text of the currently selected options
        def selected_options
          web_element.selected_options.map { |e| e.text }.compact
        end

        # @return [Array] array of strings representing the value of the currently selected options
        def selected_values
          web_element.selected_options.map { |e| e.value }.compact
        end

        def include?(value)
          web_element.include? value
        end
        
        # Returns an object representing the option for the index provided.
        # The index is zero-based.
        #
        # @return [Object] Fluent::WebElements::Option
        def [](index)
          options[index]
        end
        
        # Provides an array of Option objects that are contained within
        # a select list object.
        #
        # @return [Array] Fluent::WebElements::Option objects
        def options
          web_element.options.map { |option| ::Fluent::WebElements::Option.new(option, :platform => :watir_webdriver) }
        end
        
      end
    end
  end
end