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
    # @param driver [Object] the browser to establish the platform for
    # @return [Object] a platform object to execute tests against
    def get_platform_for(driver)
      Fluent::Platforms.list.each_value do |drv|
        return drv.create_platform_object_for(driver) if drv.works_with?(driver)
      end
      msg = "Unable to create a platform object for #{driver}."
      raise Fluent::Errors::UnableToCreatePlatform, msg
    end
    
  end
end

require 'fluent/platform_watir'
require 'fluent/platform_selenium'
require 'fluent/platform_mechanize'