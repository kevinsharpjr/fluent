module Fluent
  module Generators
    
    def url_is(url=nil)
      msg = "The url_is assertion is empty on the definition #{self}."
      raise Fluent::NoUrlForDefinition, msg if url.nil?
      
      define_method('view') do
        browser.goto(url)
      end
    end
    
    def title_is(title=nil)
      define_method('check_title') do
        msg  = "Expected title: '#{title}'; Actual title: '#{browser.title}'"
        valid_title = title == browser.title if title.kind_of?(String)
        raise Fluent::TitleNotMatched, msg unless valid_title
        valid_title
      end
    end
    
  end
end