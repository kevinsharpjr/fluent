module Fluent
  module Platforms
    
    @drivers = {}
    
    def self.register(driver, platform)
      @drivers[driver] = platform
    end
    
    def self.list
      @drivers
    end
    
    # This module determines what execution platform Fluent will use. The
    # decision is based on the browser that has been established for the
    # execution profile.
    #
    # @param browser [Object] the browser to establish the platform for
    # @return [Object] a platform object to execute tests against
    def get_platform_for(browser)
      Fluent::Platforms.list.each_value do |driver|
        return driver.create_platform_object_for(browser)
      end
    end
    
  end
end

require 'fluent/platform_watir'