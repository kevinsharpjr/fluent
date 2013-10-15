require 'fluent/version'
require 'fluent/errors'
require 'fluent/logger'
require 'fluent/platforms'
require 'fluent/generators'

require 'watir-webdriver'
require 'selenium-webdriver'

module Fluent
  include Platforms
  
  # Browser drivers will be:
  # [Watir::Browser] or [Selenium::WebDriver::Driver]
  #
  # @return [Object] browser driver reference
  attr_reader :browser

  # Platform references will be:
  # [Fluent::Platforms::WatirWebDriver::PlatformObject]
  # [Fluent::Platforms::SeleniumWebDriver::PlatformObject]
  #
  # @return [Object] platform reference
  attr_reader :platform
  
  def self.version
    "Fluent v#{Fluent::VERSION}"
  end

  # The included callback is used to provide the core functionality of the
  # library to any class or module that includes the Fluent library. The
  # calling class or module is extended with logic that the library makes
  # available as class methods. Those classes become page definitions or
  # activity definitions.
  #
  # @param caller [Class] the class including the library
  def self.included(caller)
    caller.extend Fluent::Generators
    
    Fluent.trace("#{caller.class} #{caller} is now Fluent.")
  end

  # The initialize method will be invoked when a definition includes Fluent.
  # A few key things are happening here that are critical to everything
  # working properly:
  #   (1) A browser instance is being created.
  #   (2) A platform object is created for that browser.
  #
  # @param browser [Object] a browser instance with a tool driver
  def initialize(browser=nil)
    @browser = browser
    @browser = Watir::Browser.new if browser.nil? or browser == :watir
    @browser = Selenium::WebDriver.for :firefox if browser == :selenium

    Fluent::trace("Fluent attached to browser: #{@browser}")
    
    establish_platform_object_for @browser
  end
  
  def self.can_be_enabled
    @can_be_enabled ||= [:button, :text_field]
  end
  
  def self.can_be_enabled?(method)
    can_be_enabled.include? method.to_sym
  end
  
  private

  # This method is crucial in that it sets up the platform instance that
  # will be used by just about every module that makes calls to any
  # platform-specific functionality.
  #
  # @param browser [Object] a browser instance with a tool driver
  # @return [Object] a platform object to execute tests against
  def establish_platform_object_for(browser)
    @platform = get_platform_for browser

    Fluent::trace("Fluent platform object: #{@platform}")
    @platform
  end
end
