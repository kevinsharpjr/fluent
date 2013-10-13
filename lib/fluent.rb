require 'fluent/version'
require 'fluent/logger'

require 'watir-webdriver'
require 'selenium-webdriver'

module Fluent
  
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
    Fluent.trace("#{caller.class} #{caller} is now Fluent.")
  end

  # @param browser [Object] a browser instance with a tool driver
  def initialize(browser=nil)
    @browser = browser
    @browser = Watir::Browser.new if browser.nil? or browser == :watir
    @browser = Selenium::WebDriver.for :firefox if browser == :selenium

    Fluent::trace("Fluent attached to browser: #{@browser}")
  end
  
end
