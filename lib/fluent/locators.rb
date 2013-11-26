require 'fluent/generators'

module Fluent
  module Locators
    
    def self.included(caller)
      ::Fluent::Generators.generate_locators(caller)
    end
    
    def locate_by(locator)
      locator[0] ? locator[0] : {index: 0}
    end
    
  end
end