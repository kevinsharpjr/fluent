require 'spec_helper'

class TextFieldGenerators
  include Fluent

  text_field :name, id: 'name'
  text_fields :signup, class: 'signup'
end

describe Fluent::Generators do
  let(:watir_browser)    { mock_browser_for_watir }
  let(:watir_definition) { TextFieldGenerators.new(watir_browser) }

  let(:text_field_object) { double('text_field_object') }
  let(:text_field_definition) { Fluent::WebElements::TextField.new(text_field_object, :platform => :watir_webdriver) }
  
  describe 'text field generators' do
    context 'when declared on a page definition' do
      it 'should generate methods for referencing the text field' do
        watir_definition.should respond_to(:name_object)
        watir_definition.should respond_to(:name_element)
        watir_definition.should respond_to(:name_text_field)
      end

      it 'should generate the common actions for checking the text field' do
        watir_definition.should respond_to(:name_exists?)
        watir_definition.should respond_to(:name_visible?)
        watir_definition.should respond_to(:name?)
        watir_definition.should respond_to(:name_?)
        watir_definition.should respond_to(:name_text_field?)
        watir_definition.should respond_to(:name_text_field_?)
        watir_definition.should respond_to(:name_text_field_exists?)
        watir_definition.should respond_to(:name_text_field_visible?)
      end

      it 'should generate common actions for enabled state' do
        watir_definition.should respond_to(:name_enabled?)
        watir_definition.should respond_to(:name!)
        watir_definition.should respond_to(:name_text_field!)
        watir_definition.should respond_to(:name_text_field_enabled?)
      end

      it 'should generate specific actions for interacting with the text field' do
        watir_definition.should respond_to(:name)
        watir_definition.should respond_to(:name=)
        watir_definition.should respond_to(:name_set)
        watir_definition.should respond_to(:name_get)
      end

      it 'should generate methods for multiple text fields' do
        watir_definition.should respond_to(:signup_elements)
      end
    end

    context 'when used by the watir platform' do
      it 'should locate the text field' do
        watir_browser.should_receive(:text_field).and_return(watir_browser)
        web_element = watir_definition.name_object
        web_element.should_not be_nil
        web_element.should be_instance_of Fluent::WebElements::TextField
      end

      it 'should locate multiple text field' do
        watir_browser.should_receive(:text_fields).and_return(watir_browser)
        watir_browser.should_receive(:[]).and_return(text_field_definition)
        watir_browser.should_receive(:map).and_return(watir_browser)
        web_elements = watir_definition.signup_elements
        web_elements.should_not be_nil
        web_elements[0].should be_instance_of Fluent::WebElements::TextField
      end
      
      it 'should enter text into a text field' do
        watir_browser.should_receive(:text_field).twice.and_return(watir_browser)
        watir_browser.should_receive(:set).twice.with('testing')
        watir_definition.name = 'testing'
        watir_definition.name_set 'testing'
      end

      it 'should retrieve text from the text field' do
        watir_browser.should_receive(:text_field).twice.and_return(watir_browser)
        watir_browser.should_receive(:value).twice.and_return('testing')
        watir_definition.name.should == 'testing'
        watir_definition.name_get.should == 'testing'
      end

      it 'should determine if a text field exists' do
        watir_browser.should_receive(:text_field).exactly(3).times.and_return(watir_browser)
        watir_browser.should_receive(:exists?).exactly(3).times.and_return(watir_browser)
        watir_definition.name_text_field_exists?.should be_true
        watir_definition.name_exists?.should be_true
        watir_definition.name?.should be_true
      end

      it 'should determine if a text field is visible' do
        watir_browser.should_receive(:text_field).exactly(3).times.and_return(watir_browser)
        watir_browser.should_receive(:present?).exactly(3).times.and_return(watir_browser)
        watir_definition.name_text_field_visible?.should be_true
        watir_definition.name_visible?.should be_true
        watir_definition.name_?.should be_true
      end

      it 'should determine if a text field is enabled' do
        watir_browser.should_receive(:text_field).exactly(3).times.and_return(watir_browser)
        watir_browser.should_receive(:enabled?).exactly(3).times.and_return(watir_browser)
        watir_definition.name_text_field_enabled?.should be_true
        watir_definition.name_enabled?.should be_true
        watir_definition.name!.should be_true
      end
    end
  end
end