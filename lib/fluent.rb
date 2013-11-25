require 'fluent/version'
require 'fluent/errors'
require 'fluent/logger'
require 'fluent/factory'
require 'fluent/platforms'
require 'fluent/enclosers'
require 'fluent/evaluators'
require 'fluent/generators'
require 'fluent/locators'
require 'fluent/data_setter'
require 'fluent/data_builder'

require 'watir-webdriver'
require 'selenium-webdriver'
require 'mechanize'

module Fluent
  include Platforms
  include Evaluators
  include Enclosers
  include Locators
  include DataSetter
  include DataBuilder
  
  # Browser drivers will be:
  # [Watir::Browser] or [Selenium::WebDriver::Driver]
  #
  # @return [Object] browser driver reference
  attr_reader :driver

  # Platform references will be:
  # [Fluent::Platforms::WatirWebDriver::PlatformObject]
  # [Fluent::Platforms::SeleniumWebDriver::PlatformObject]
  # [Fluent::Platforms::MechanizeDriver::PlatformObject]
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
  # @param driver [Object] a tool driver instance
  def initialize(driver=nil, visit=nil)
    @driver = driver
    
    Fluent::trace("Fluent attached to driver: #{@driver}")
    
    establish_platform_object_for @driver
    
    view if visit && respond_to?(:view)
    
    initialize_page if respond_to?(:initialize_page)
    initialize_activity if respond_to?(:initialize_activity)
  end

  # Returns the default wait value for pages. This value is the default
  # value beyond which a timeout is assumed.
  def self.page_level_wait
    @page_wait ||= 15
  end

  def self.page_level_wait=(value)
    @page_wait = value
  end
  
  # Returns the default wait value for elements on a page. This value is
  # the default value beyond which a timeout is assumed.
  def self.element_level_wait
    @element_wait ||= 5
  end

  def self.element_level_wait=(value)
    @element_wait = value
  end
  
  def self.can_be_enabled
    @can_be_enabled ||= [:button, :text_field, :text_area, :checkbox, :select_list, :radio]
  end
  
  def self.can_display_text
    @can_display_text ||= [:button, :link, :list_item, :ordered_list, :unordered_list,
                           :label, :div, :span, :cell, :table, :h1, :h2, :h3, :h4, :h5, :h6]
  end
  
  def self.can_be_enabled?(method)
    can_be_enabled.include? method.to_sym
  end
  
  def self.can_display_text?(method)
    can_display_text.include? method.to_sym
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
