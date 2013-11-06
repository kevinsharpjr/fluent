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

      end
    end
  end
end