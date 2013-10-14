module Fluent
  module Generators
    
    def url_is(url=nil)
      msg = "The url_is assertion is empty on the definition #{self}."
      raise Fluent::Errors::NoUrlForDefinition, msg if url.nil?
      
      define_method('view') do
        platform.visit(url)
      end
    end
    
    def title_is(title=nil)
      msg = "The title_is assertion is empty on the definition #{self}."
      raise Fluent::Errors::NoTitleForDefinition, msg if title.nil?
      
      define_method('check_title') do
        msg  = "Expected title: '#{title}'; Actual title: '#{browser.title}'"
        valid_title = title == browser.title if title.kind_of?(String)
        valid_title = title =~ browser.title if title.kind_of?(Regexp)
        raise Fluent::Errors::TitleNotMatched, msg unless valid_title
        valid_title
      end
    end
    
    def link(identifier, locator)
      define_method("#{identifier}_object") do
        platform.send('link', locator)
      end

      alias_method "#{identifier}_element".to_sym, "#{identifier}_object".to_sym
    end
    
  end
end