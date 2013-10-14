module Fluent
  module Platforms
    module WatirWebDriver
      
      def self.create_platform_object_for(browser)
        require 'fluent/platform_watir/platform_object'
        return WatirWebDriver::PlatformObject.new(browser)
      end
      
    end
  end
end

Fluent::Platforms.register(:watir_webdriver, Fluent::Platforms::WatirWebDriver)