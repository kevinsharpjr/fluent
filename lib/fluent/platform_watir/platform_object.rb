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
          WebElements::Link.new(element_object)
        end
        
      end
    end
  end
end

Dir["#{File.dirname(__FILE__)}/../web_elements/**/*.rb"].each { |file| require file }