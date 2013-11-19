require 'watir-webdriver'
require 'selenium-webdriver'

def mock_browser_for_watir
  watir_browser = double('watir')
  watir_browser.stub(:is_a?).with(Watir::Browser).and_return(true)
  watir_browser.stub(:is_a?).with(Selenium::WebDriver::Driver).and_return(false)
  watir_browser
end

def mock_browser_for_selenium
  selenium_browser = double('selenium')
  selenium_browser.stub(:is_a?).with(Watir::Browser).and_return(false)
  selenium_browser.stub(:is_a?).with(Selenium::WebDriver::Driver).and_return(true)
  selenium_browser
end

def mock_browser_for_mechanize
  mechanize_browser = double('mechanize')
  mechanize_browser.stub(:is_a?).with(Watir::Browser).and_return(false)
  mechanize_browser.stub(:is_a?).with(Selenium::WebDriver::Driver).and_return(false)
  mechanize_browser.stub(:is_a?).with(Mechanize).and_return(true)
  mechanize_browser
end

class TestDefinition
  include Fluent

  url_is 'http://localhost:4567'
  title_is 'Test App'
  
  look_for :name
  
  text_field :name, id: 'name'
  
  within_frame(id: 'frame') do |frame|
    text_field :framedName, id: 'framedName', frame: frame
  end
end