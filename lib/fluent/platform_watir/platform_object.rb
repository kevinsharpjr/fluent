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
          reference_web_element('link(locator)', WebElements::Link, locator)
        end
        
        def paragraph(locator)
          reference_web_element('p(locator)', WebElements::Paragraph, locator)
        end
        
        def reference_web_element(action, object, locator)
          element_object = browser.instance_eval(action)
          object.new(element_object, :platform => :watir_webdriver)
        end
        
      end
    end
  end
end

require 'fluent/web_elements/web_element'
file_list = Dir["#{File.dirname(__FILE__)}/../web_elements/**/*.rb"].reject { |file| file =~ /web_element.rb/ }
file_list.each { |file| require file }