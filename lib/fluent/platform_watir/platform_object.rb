module Fluent
  module Platforms
    module WatirWebDriver
      class PlatformObject
        
        attr_reader :browser
        
        def initialize(browser)
          @browser = browser
        end
        
        ## Browser-Level Actions ##
        
        def visit(url)
          browser.goto(url)
        end
        
        ## Generator Actions ##
        
        def link(locator)
          element_object = browser.instance_eval('link(locator)')
          WebElements::Link.new(element_object, :platform => :watir_webdriver)
        end
        
        def paragraph(locator)
          element_object = browser.instance_eval('p(locator)')
          WebElements::Paragraph.new(element_object, :platform => :watir_webdriver)
        end
        
      end
    end
  end
end

require 'fluent/web_elements/web_element'
file_list = Dir["#{File.dirname(__FILE__)}/../web_elements/**/*.rb"].reject { |file| file =~ /web_element.rb/ }
file_list.each { |file| require file }