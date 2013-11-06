module Fluent
  module Platforms
    module SeleniumWebDriver
      class PlatformObject

        attr_reader :driver
        
        def initialize(driver)
          @driver = driver
        end

        ## Browser-Level Actions ##

        def visit(url)
          driver.navigate.to(url)
        end
        
      end
    end
  end
end