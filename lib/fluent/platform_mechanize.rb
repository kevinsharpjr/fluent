module Fluent
  module Platforms
    module MechanizeDriver

      def self.create_platform_object_for(driver)
        require 'fluent/platform_mechanize/platform_object'
        return MechanizeDriver::PlatformObject.new(driver)
      end

      def self.works_with?(driver)
        driver.is_a?(::Mechanize)
      end

    end
  end
end

Fluent::Platforms.register(:mechanize, Fluent::Platforms::MechanizeDriver)