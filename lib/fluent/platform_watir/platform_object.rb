module Fluent
  module Platforms
    module WatirWebDriver
      class PlatformObject
        
        attr_reader :driver
        
        def initialize(driver)
          @driver = driver
        end
        
        ## Browser-Level Actions ##
        
        def visit(url)
          driver.goto(url.to_s)
        end
        
        def get_cookie_value(name)
          for cookie in @driver.cookies.to_a
            if cookie[:name] == name
              return cookie[:value]
            end
          end
          nil
        end
        
        def url
          driver.url
        end

        def remove_cookies
          driver.cookies.clear
        end

        def refresh
          driver.refresh
        end

        def run_script(script)
          driver.execute_script(script)
        end

        def screenshot(file)
          driver.wd.save_screenshot(file)
        end
        
        ## Page-Level Actions ##

        def markup
          driver.html
        end
        
        def title
          driver.title
        end
        
        def text
          driver.text
        end

        def wait_until(timeout, message='wait condition was not found', &block)
          driver.wait_until(timeout, message, &block)
        end
        
        def focused
          web_element = driver.execute_script('return document.activeElement')
          type = web_element.type.to_sym if web_element.tag_name.to_sym == :input
          object_class = ::Fluent::WebElements.get_class_for(web_element.tag_name, type)
          object_class.new(web_element, :platform => :watir_webdriver)
        end
        
        ## Encloser Actions ##
        
        def will_alert(&block)
          yield
          value = nil
          if driver.alert.exists?
            value = driver.alert.text
            driver.alert.ok
          end
          value
        end
        
        def will_confirm(response, &block)
          yield
          value = nil
          if driver.alert.exists?
            value = driver.alert.text
            response ? driver.alert.ok : driver.alert.close
          end
          value
        end
        
        def will_prompt(response, &block)
          cmd = "window.prompt = function(text, value) {window.__lastWatirPrompt = {message: text, default_value: value}; return '#{response}';}"
          driver.wd.execute_script(cmd)
          yield
          result = driver.wd.execute_script('return window.__lastWatirPrompt')
          result && result.dup.each_key { |k| result[k.to_sym] = result.delete(k) }
          result
        end
        
        def within_window(locator, &block)
          identifier = {locator.keys.first => /#{Regexp.escape(locator.values.first)}/}
          driver.window(identifier).use(&block)
        end
        
        ## Generator Actions ##
        
        def link(locator)
          reference_web_element('link(locator)', WebElements::Link, locator)
        end
        
        def links(locator)
          reference_web_elements('links(locator)', WebElements::Link, locator)
        end
        
        def link_click(locator)
          access_web_element('link(locator).click', locator)
        end
        
        def button(locator)
          reference_web_element('button(locator)', WebElements::Button, locator)
        end
        
        def buttons(locator)
          reference_web_elements('buttons(locator)', WebElements::Button, locator)
        end
        
        def button_click(locator)
          access_web_element('button(locator).click', locator)
        end
        
        def text_field(locator)
          reference_web_element('text_field(locator)', WebElements::TextField, locator)
        end
        
        def text_fields(locator)
          reference_web_elements('text_fields(locator)', WebElements::TextField, locator)
        end
        
        def text_field_set(locator, value)
          access_web_element('text_field(locator).set(value)', locator, value)
        end
        
        def text_field_get(locator)
          access_web_element('text_field(locator).value', locator)
        end

        def text_area(locator)
          reference_web_element('textarea(locator)', WebElements::TextArea, locator)
        end
        
        def text_areas(locator)
          reference_web_elements('textareas(locator)', WebElements::TextArea, locator)
        end
        
        def text_area_set(locator, value)
          access_web_element('textarea(locator).set(value)', locator, value)
        end
        
        def text_area_get(locator)
          access_web_element('textarea(locator).value', locator)
        end
        
        def checkbox(locator)
          reference_web_element('checkbox(locator)', WebElements::CheckBox, locator)
        end
        
        def checkboxes(locator)
          reference_web_elements('checkboxes(locator)', WebElements::CheckBox, locator)
        end
        
        alias_method :checkboxs, :checkboxes
        
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

        def select_lists(locator)
          reference_web_elements('select_lists(locator)', WebElements::SelectList, locator)
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

        def radios(locator)
          reference_web_elements('radios(locator)', WebElements::Radio, locator)
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

        def paragraphs(locator)
          reference_web_elements('ps(locator)', WebElements::Paragraph, locator)
        end
        
        def paragraph_text(locator)
          access_web_element('p(locator).text', locator)
        end

        def div(locator)
          reference_web_element('div(locator)', WebElements::Div, locator)
        end

        def divs(locator)
          reference_web_elements('divs(locator)', WebElements::Div, locator)
        end
        
        def div_text(locator)
          access_web_element('div(locator).text', locator)
        end

        def span(locator)
          reference_web_element('span(locator)', WebElements::Span, locator)
        end
        
        def spans(locator)
          reference_web_elements('spans(locator)', WebElements::Span, locator)
        end
        
        def span_text(locator)
          access_web_element('span(locator).text', locator)
        end
        
        def ordered_list(locator)
          reference_web_element('ol(locator)', WebElements::OrderedList, locator)
        end

        def ordered_lists(locator)
          reference_web_elements('ols(locator)', WebElements::OrderedList, locator)
        end
        
        def ordered_list_text(locator)
          access_web_element('ol(locator).text', locator)
        end

        def unordered_list(locator)
          reference_web_element('ul(locator)', WebElements::UnorderedList, locator)
        end
        
        def unordered_lists(locator)
          reference_web_elements('uls(locator)', WebElements::UnorderedList, locator)
        end
        
        def unordered_list_text(locator)
          access_web_element('ul(locator).text', locator)
        end

        def list_item(locator)
          reference_web_element('li(locator)', WebElements::ListItem, locator)
        end

        def list_items(locator)
          reference_web_elements('lis(locator)', WebElements::ListItem, locator)
        end

        def list_item_text(locator)
          access_web_element('li(locator).text', locator)
        end

        def table(locator)
          reference_web_element('table(locator)', WebElements::Table, locator)
        end
        
        def tables(locator)
          reference_web_elements('tables(locator)', WebElements::Table, locator)
        end
        
        def table_text(locator)
          access_web_element('table(locator).text', locator)
        end

        def cell(locator)
          reference_web_element('td(locator)', WebElements::Cell, locator)
        end
        
        def cells(locator)
          reference_web_elements('tds(locator)', WebElements::Cell, locator)
        end
        
        def cell_text(locator)
          access_web_element('td(locator).text', locator)
        end
        
        def label(locator)
          reference_web_element('label(locator)', WebElements::Label, locator)
        end
        
        def labels(locator)
          reference_web_elements('labels(locator)', WebElements::Label, locator)
        end
        
        def label_text(locator)
          access_web_element('label(locator).text', locator)
        end

        def hidden(locator)
          reference_web_element('hidden(locator)', WebElements::Hidden, locator)
        end

        def hiddens(locator)
          reference_web_elements('hiddens(locator)', WebElements::Hidden, locator)
        end
        
        def hidden_value(locator)
          access_web_element('hidden(locator).value', locator)
        end
        
        def h1(locator)
          reference_web_element('h1(locator)', WebElements::Heading, locator)
        end

        def h1s(locator)
          reference_web_elements('h1s(locator)', WebElements::Heading, locator)
        end
        
        def h1_text(locator)
          access_web_element('h1(locator).text', locator)
        end

        def h2(locator)
          reference_web_element('h2(locator)', WebElements::Heading, locator)
        end

        def h2s(locator)
          reference_web_elements('h2s(locator)', WebElements::Heading, locator)
        end

        def h2_text(locator)
          access_web_element('h2(locator).text', locator)
        end

        def h3(locator)
          reference_web_element('h3(locator)', WebElements::Heading, locator)
        end

        def h3s(locator)
          reference_web_elements('h3s(locator)', WebElements::Heading, locator)
        end

        def h3_text(locator)
          access_web_element('h3(locator).text', locator)
        end

        def h4(locator)
          reference_web_element('h4(locator)', WebElements::Heading, locator)
        end

        def h4s(locator)
          reference_web_elements('h4s(locator)', WebElements::Heading, locator)
        end

        def h4_text(locator)
          access_web_element('h4(locator).text', locator)
        end

        def h5(locator)
          reference_web_element('h5(locator)', WebElements::Heading, locator)
        end

        def h5s(locator)
          reference_web_elements('h5s(locator)', WebElements::Heading, locator)
        end

        def h5_text(locator)
          access_web_element('h5(locator).text', locator)
        end

        def h6(locator)
          reference_web_element('h6(locator)', WebElements::Heading, locator)
        end

        def h6s(locator)
          reference_web_elements('h6s(locator)', WebElements::Heading, locator)
        end

        def h6_text(locator)
          access_web_element('h6(locator).text', locator)
        end
        
        def form(locator)
          reference_web_element('form(locator)', WebElements::Form, locator)
        end
        
        def forms(locator)
          reference_web_elements('forms(locator)', WebElements::Form, locator)
        end
        
        def image(locator)
          reference_web_element('image(locator)', WebElements::Image, locator)
        end
        
        def images(locator)
          reference_web_elements('images(locator)', WebElements::Image, locator)
        end
        
        def image_action(locator, action)
          access_web_element("image(locator).#{action}", locator)
        end
        
        def image_get_source(locator)
          access_web_element("image(locator).attribute_value('src')", locator)
        end
        
        def image_get_alt_text(locator)
          access_web_element("image(locator).attribute_value('alt')", locator)
        end
        
        alias_method :radio_button, :radio
        alias_method :textarea, :text_area
        alias_method :textfield, :text_field
        alias_method :a, :link
        alias_method :p, :paragraph
        alias_method :ol, :ordered_list
        alias_method :ul, :unordered_list
        alias_method :li, :list_item
        alias_method :td, :cell
        alias_method :img, :image
        
        # This method is called by any platform methods that require getting
        # an object reference.
        #
        # @param action [String] the driver logic to be sent to the browser
        # @param object [Object] the type of web object that will receive the action
        # @param locator [Hash] the specific web object selector
        # @return [Object] the web object identified by the action
        def reference_web_element(action, object, locator)
          encloser = locator.delete(:frame)
          element_object = driver.instance_eval("#{enclosed_by(encloser)}#{action}")
          object.new(element_object, :platform => :watir_webdriver)
        end
        
        def reference_web_elements(action, object, locator)
          encloser = locator.delete(:frame)
          element_objects = driver.instance_eval("#{enclosed_by(encloser)}#{action}")
          element_objects.map do |element|
            object.new(element, :platform => :watir_webdriver)
          end
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
          driver.instance_eval("#{enclosed_by(encloser)}#{action}")
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

# This require brings in the high-level web element mapping calls.
require 'fluent/web_elements'

# The statements below are used to bring in all of the web elements that
# Fluent recognizes. /web_elements/web_element must be brought in first
# so that happens and then it is rejected from being required twice.
require 'fluent/web_elements/web_element'
file_list = Dir["#{File.dirname(__FILE__)}/../web_elements/**/*.rb"].reject { |file| file =~ /web_element.rb/ }
file_list.each { |file| require file }