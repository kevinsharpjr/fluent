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
        
        def link_click(locator)
          browser.instance_eval('link(locator).click')
        end
        
        def button(locator)
          reference_web_element('button(locator)', WebElements::Button, locator)
        end
        
        def button_click(locator)
          browser.instance_eval('button(locator).click')
        end
        
        def text_field(locator)
          puts "Platform object text field locator: #{locator}"
          
          reference_web_element('text_field(locator)', WebElements::TextField, locator)
        end
        
        def text_field_set(locator, value)
          puts "Platform object text field set locator: #{locator}"
          
          access_web_element('text_field(locator).set(value)', locator, value)
          #browser.instance_eval('text_field(locator).set(value)')
        end
        
        def text_field_get(locator)
          browser.instance_eval('text_field(locator).value')
        end
        
        def checkbox(locator)
          reference_web_element('checkbox(locator)', WebElements::CheckBox, locator)
        end
        
        def checkbox_check_state(locator)
          browser.instance_eval('checkbox(locator).set?')
        end
        
        def checkbox_check(locator)
          browser.instance_eval('checkbox(locator).set')
        end
        
        def checkbox_uncheck(locator)
          browser.instance_eval('checkbox(locator).clear')
        end
        
        def select_list(locator)
          reference_web_element('select_list(locator)', WebElements::SelectList, locator)
        end
        
        def select_list_get_selected(locator)
          browser.instance_eval('select_list(locator).selected_options[0].text')
        end
        
        def select_list_set(locator, value)
          browser.instance_eval('select_list(locator).select(value)')
        end
        
        def select_list_get_value(locator)
          browser.instance_eval('select_list(locator).value')
        end
        
        def radio(locator)
          reference_web_element('radio(locator)', WebElements::Radio, locator)
        end
        
        def radio_select(locator)
          browser.instance_eval('radio(locator).set')
        end
        
        def radio_check_state(locator)
          browser.instance_eval('radio(locator).set?')
        end
        
        def paragraph(locator)
          reference_web_element('p(locator)', WebElements::Paragraph, locator)
        end
        
        def paragraph_text(locator)
          browser.instance_eval('p(locator).text')
        end
        
        def reference_web_element(action, object, locator)
          puts "Reference web element | locator = #{locator}"
          
          encloser = locator.delete(:frame)

          puts "ACCESS STRING: #{enclosed_by(encloser)}#{action}"
          
          element_object = browser.instance_eval("#{enclosed_by(encloser)}#{action}")
          object.new(element_object, :platform => :watir_webdriver)
        end
        
        def access_web_element(action, locator, value=nil)
          puts "Access web element | locator = #{locator}"
          
          encloser = locator.delete(:frame)
          
          puts "ACCESS STRING: #{enclosed_by(encloser)}#{action}"
          
          browser.instance_eval("#{enclosed_by(encloser)}#{action}")
        end
        
        def enclosed_by(encloser)
          return if encloser.nil?

          key = encloser[0].keys.first
          value = encloser[0].values.first
          
          "frame(:#{key} => '#{value}')."
        end
        
      end
    end
  end
end

require 'fluent/web_elements/web_element'
file_list = Dir["#{File.dirname(__FILE__)}/../web_elements/**/*.rb"].reject { |file| file =~ /web_element.rb/ }
file_list.each { |file| require file }