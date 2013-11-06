module Fluent
  module Platforms
    module WatirWebDriver
      
      def self.create_platform_object_for(driver)
        require 'fluent/platform_watir/platform_object'
        return WatirWebDriver::PlatformObject.new(driver)
      end
      
      def self.works_with?(driver)
        driver.is_a?(::Watir::Browser)
      end
      
    end
  end
end

Fluent::Platforms.register(:watir_webdriver, Fluent::Platforms::WatirWebDriver)