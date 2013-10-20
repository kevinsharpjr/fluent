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
        
        def url
          browser.url
        end

        def remove_cookies
          browser.cookies.clear
        end

        def refresh
          browser.refresh
        end

        def run_script(script)
          browser.execute_script(script)
        end

        def screenshot(file)
          browser.wd.save_screenshot(file)
        end
        
        ## Page-Level Actions ##

        def markup
          browser.html
        end
        
        def title
          browser.title
        end
        
        def text
          browser.text
        end

        ## Encloser Actions ##
        
        def will_alert(&block)
          yield
          value = nil
          if browser.alert.exists?
            value = browser.alert.text
            browser.alert.ok
          end
          value
        end
        
        def will_confirm(response, &block)
          yield
          value = nil
          if browser.alert.exists?
            value = browser.alert.text
            response ? browser.alert.ok : browser.alert.close
          end
          value
        end
        
        ## Generator Actions ##
        
        def link(locator)
          reference_web_element('link(locator)', WebElements::Link, locator)
        end
        
        def link_click(locator)
          access_web_element('link(locator).click', locator)
        end
        
        def button(locator)
          reference_web_element('button(locator)', WebElements::Button, locator)
        end
        
        def button_click(locator)
          access_web_element('button(locator).click', locator)
        end
        
        def text_field(locator)
          reference_web_element('text_field(locator)', WebElements::TextField, locator)
        end
        
        def text_field_set(locator, value)
          access_web_element('text_field(locator).set(value)', locator, value)
        end
        
        def text_field_get(locator)
          access_web_element('text_field(locator).value', locator)
        end
        
        def checkbox(locator)
          reference_web_element('checkbox(locator)', WebElements::CheckBox, locator)
        end
        
        def checkbox_check_state(locator)
          access_web_element('checkbox(locator).set?', locator)
        end
        
        def checkbox_check(locator)
          access_web_element('checkbox(locator).set', locator)
        end
        
        def checkbox_uncheck(locator)
          access_web_element('checkbox(locator).clear', locator)
        end
        
        def select_list(locator)
          reference_web_element('select_list(locator)', WebElements::SelectList, locator)
        end
        
        def select_list_get_selected(locator)
          access_web_element('select_list(locator).selected_options[0].text', locator)
        end
        
        def select_list_set(locator, value)
          access_web_element('select_list(locator).select(value)', locator, value)
        end
        
        def select_list_get_value(locator)
          access_web_element('select_list(locator).value', locator)
        end
        
        def radio(locator)
          reference_web_element('radio(locator)', WebElements::Radio, locator)
        end
        
        def radio_select(locator)
          access_web_element('radio(locator).set', locator)
        end
        
        def radio_check_state(locator)
          access_web_element('radio(locator).set?', locator)
        end
        
        def paragraph(locator)
          reference_web_element('p(locator)', WebElements::Paragraph, locator)
        end
        
        def paragraph_text(locator)
          access_web_element('p(locator).text', locator)
        end
        
        def reference_web_element(action, object, locator)
          encloser = locator.delete(:frame)
          element_object = browser.instance_eval("#{enclosed_by(encloser)}#{action}")
          #puts "Element Object (evaluated): #{enclosed_by(encloser)}#{action}"
          #puts "Element Object (locator): #{locator}"
          #puts "Element Object (reference): #{element_object.inspect}"
          object.new(element_object, :platform => :watir_webdriver)
        end
        
        def access_web_element(action, locator, value=nil)
          encloser = locator.delete(:frame)
          #puts "Element Object (accessing): #{enclosed_by(encloser)}#{action}"
          #puts "Element Object (locator): #{locator}"
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