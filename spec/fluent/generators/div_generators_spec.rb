require 'spec_helper'

class DivGenerators
  include Fluent

  div :section, id: 'section'
  divs :sections, class: 'sections'
end

describe Fluent::Generators do
  let(:watir_browser)    { mock_browser_for_watir }
  let(:watir_definition) { DivGenerators.new(watir_browser) }

  let(:div_object) { double('div_object') }
  let(:div_definition) { Fluent::WebElements::Div.new(div_object, :platform => :watir_webdriver) }

  describe 'div generators' do
    context 'when declared on a page definition' do
      it 'should generate methods for referencing the div' do
        watir_definition.should respond_to(:section_object)
        watir_definition.should respond_to(:section_element)
        watir_definition.should respond_to(:section_div)
      end

      it 'should generate the common actions for checking the div' do
        watir_definition.should respond_to(:section_exists?)
        watir_definition.should respond_to(:section_visible?)
        watir_definition.should respond_to(:section?)
        watir_definition.should respond_to(:section_?)
        watir_definition.should respond_to(:section_div?)
        watir_definition.should respond_to(:section_div_?)
        watir_definition.should respond_to(:section_div_exists?)
        watir_definition.should respond_to(:section_div_visible?)
      end

      it 'should generate specific actions for interacting with the div' do
        watir_definition.should respond_to(:section)
      end
      
      it 'should retrieve text from the div' do
        watir_definition.should respond_to(:section_text)
      end

      it 'should generate methods for multiple divs' do
        watir_definition.should respond_to(:sections_elements)
      end
    end

    context 'when used by the watir platform' do
      it 'should locate the div' do
        watir_browser.should_receive(:div).and_return(watir_browser)
        web_element = watir_definition.section_div
        web_element.should_not be_nil
        web_element.should be_instance_of Fluent::WebElements::Div
      end

      it 'should locate multiple divs' do
        watir_browser.should_receive(:divs).and_return(watir_browser)
        watir_browser.should_receive(:[]).and_return(div_definition)
        watir_browser.should_receive(:map).and_return(watir_browser)
        web_elements = watir_definition.sections_elements
        web_elements.should_not be_nil
        web_elements[0].should be_instance_of Fluent::WebElements::Div
      end

      it 'should return the text of a div' do
        watir_browser.should_receive(:div).and_return(watir_browser)
        watir_browser.should_receive(:text).and_return('testing')
        watir_definition.section.should == 'testing'
      end
    end
  end
end