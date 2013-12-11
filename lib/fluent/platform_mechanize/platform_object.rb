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
          driver.get(url).body
        end
        
        def markup
          driver.current_page.body
        end
        
        def get_cookie_value(name)
          for cookie in driver.cookie_jar.cookies 
            if cookie.name == "DotomiUser"
              return /\d*/.match(cookie.value).to_s.to_i
            end
          end
          null
        end
      end
    end
  end
end