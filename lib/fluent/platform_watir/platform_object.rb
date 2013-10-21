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

        def wait_until(timeout, message='wait condition was not found', &block)
          browser.wait_until(timeout, message, &block)
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
        
        def will_prompt(response, &block)
          cmd = "window.prompt = function(text, value) {window.__lastWatirPrompt = {message: text, default_value: value}; return #{!!response};}"
          browser.wd.execute_script(cmd)
          yield
          result = browser.wd.execute_script('return window.__lastWatirPrompt')
          result && result.dup.each_key { |k| result[k.to_sym] = result.delete(k) }
          result
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

        def text_area(locator)
          reference_web_element('text_area(locator)', WebElements::TextArea, locator)
        end
        
        def text_area_set(locator, value)
          access_web_element('text_area(locator).set(value)', locator, value)
        end
        
        def text_area_get(locator)
          access_web_element('text_area(locator).value', locator)
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

        def div(locator)
          reference_web_element('div(locator)', WebElements::Div, locator)
        end

        def div_text(locator)
          access_web_element('div(locator).text', locator)
        end

        def span(locator)
          reference_web_element('span(locator)', WebElements::Span, locator)
        end

        def span_text(locator)
          access_web_element('span(locator).text', locator)
        end
        
        # This method is called by any platform methods that require getting
        # an object reference.
        #
        # @param action [String] the driver logic to be sent to the browser
        # @param object [Object] the type of web object that will receive the action
        # @param locator [Hash] the specific web object selector
        # @return [Object] the web object identified by the action
        def reference_web_element(action, object, locator)
          encloser = locator.delete(:frame)
          element_object = browser.instance_eval("#{enclosed_by(encloser)}#{action}")
          object.new(element_object, :platform => :watir_webdriver)
        end

        # This method is called by any platform methods that require accessing
        # a web object with the intent of manipulating it or getting information
        # from it.
        #
        # @param action [String] the driver logic to be sent to the browser
        # @param locator [Hash] the specific web object selector
        # @param value [String] any specific information that must be sent to the web object
        # @return [Any] the information or object returned by the action
        def access_web_element(action, locator, value=nil)
          encloser = locator.delete(:frame)
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