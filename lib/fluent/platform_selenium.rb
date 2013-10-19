module Fluent
  module Platforms
    module SeleniumWebDriver

      def self.create_platform_object_for(browser)
        require 'fluent/platform_selenium/platform_object'
        return SeleniumWebDriver::PlatformObject.new(browser)
      end

      def self.works_with?(browser)
        browser.is_a?(::Selenium::WebDriver::Driver)
      end

    end
  end
end

Fluent::Platforms.register(:selenium_webdriver, Fluent::Platforms::SeleniumWebDriver)