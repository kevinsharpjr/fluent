require 'spec_helper'

class TextAreaGenerators
  include Fluent

  text_area :summary, id: 'summary'
  text_areas :signup, class: 'signup'
end

describe Fluent::Generators do
  let(:watir_browser)    { mock_browser_for_watir }
  let(:watir_definition) { TextAreaGenerators.new(watir_browser) }

  let(:text_area_object) { double('text_area_object') }
  let(:text_area_definition) { Fluent::WebElements::TextArea.new(text_area_object, :platform => :watir_webdriver) }
  
  describe 'text area generators' do
    context 'when declared on a page definition' do
      it 'should generate methods for referencing the text area' do
        watir_definition.should respond_to(:summary_object)
        watir_definition.should respond_to(:summary_element)
        watir_definition.should respond_to(:summary_text_area)
      end

      it 'should generate methods for interacting with the text area' do
        watir_definition.should respond_to(:summary)
        watir_definition.should respond_to(:summary_exists?)
        watir_definition.should respond_to(:summary_visible?)
        watir_definition.should respond_to(:summary?)
        watir_definition.should respond_to(:summary_?)
        watir_definition.should respond_to(:summary_text_area_exists?)
        watir_definition.should respond_to(:summary_text_area_visible?)
        watir_definition.should respond_to(:summary_text_area?)
        watir_definition.should respond_to(:summary_text_area_?)
      end

      it 'should generate methods for multiple text areas' do
        watir_definition.should respond_to(:signup_elements)
      end
    end

    context 'when used by the watir platform' do
      it 'should locate the text area' do
        watir_browser.should_receive(:textarea).and_return(watir_browser)
        web_element = watir_definition.summary_object
        web_element.should_not be_nil
        web_element.should be_instance_of Fluent::WebElements::TextArea
      end

      it 'should locate multiple text areas' do
        watir_browser.should_receive(:textareas).and_return(watir_browser)
        watir_browser.should_receive(:[]).and_return(text_area_definition)
        watir_browser.should_receive(:map).and_return(watir_browser)
        web_elements = watir_definition.signup_elements
        web_elements.should_not be_nil
        web_elements[0].should be_instance_of Fluent::WebElements::TextArea
      end
      
      it 'should retrieve text from the text area' do
        watir_browser.should_receive(:textarea).and_return(watir_browser)
        watir_browser.should_receive(:value).and_return('testing')
        watir_definition.summary.should == 'testing'
      end

      it 'should enter text into a text area' do
        watir_browser.should_receive(:textarea).and_return(watir_browser)
        watir_browser.should_receive(:set).with('testing')
        watir_definition.summary = 'testing'
      end
    end
  end
end