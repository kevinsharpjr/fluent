module Fluent
  module Platforms
    module MechanizeDriver
      class PlatformObject

        attr_reader :driver

        def initialize(driver)
          @driver = driver
        end

        ## Browser-Level Actions ##

        def visit(url)
          driver.get(url)
        end
        
        def markup
          driver.current_page.body
        end
        
        def get_cookie_value(name)
          for cookie in driver.cookie_jar.cookies 
            if cookie.name == name
              return cookie.value
            end
          end
        end
      end
    end
  end
end