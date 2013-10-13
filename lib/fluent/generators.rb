module Fluent
  module Generators
    
    def url_is(url)
      define_method('view') do
        browser.goto(url)
      end
    end
    
  end
end