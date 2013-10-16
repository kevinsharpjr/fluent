module Fluent
  module Platforms
    module WatirWebDriver
      module SelectList
        
        def [](index)
          ::Fluent::WebElements::Option.new(options[index], :platform => :watir_webdriver)
        end
        
        # Provides an array of Option objects that are contained within
        # a select list object.
        #
        # @return [Array] Fluent::WebElements::Option objects
        def options
          elements = []
          options = web_element.wd.find_elements(:xpath, option_xpath)
          options.each do |option|
            elements << ::Fluent::WebElements::Option.new(option, :platform => :watir_webdriver)
          end
          elements
        end
        
        def option_xpath
          './/child::option'
        end
        
      end
    end
  end
end