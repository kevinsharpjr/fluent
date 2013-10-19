module Fluent
  module Platforms
    module SeleniumWebDriver
      class PlatformObject

        attr_reader :browser
        
        def initialize(browser)
          @browser = browser
        end

        ## Browser-Level Actions ##

        def visit(url)
          browser.navigate.to(url)
        end
        
      end
    end
  end
end