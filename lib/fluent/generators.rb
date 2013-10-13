module Fluent
  module Generators
    
    def url_is(url=nil)
      msg = "The url_is assertion is empty on the definition #{self}."
      raise Fluent::NoUrlForDefinition, msg if url.nil?
      
      define_method('view') do
        browser.goto(url)
      end
    end
    
  end
end