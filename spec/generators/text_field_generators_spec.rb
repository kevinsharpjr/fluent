require_relative '../spec_helper'

class TextFieldGenerators
  include Fluent

  text_field :name, id: 'name'
end

describe Fluent::Generators do
  let(:watir_browser)    { mock_browser_for_watir }
  let(:watir_definition) { TextFieldGenerators.new(watir_browser) }

  describe 'text field generators' do
    context 'when declared on a page definition' do
      it 'should generate methods for referencing the text field' do
        watir_definition.should respond_to(:name_object)
        watir_definition.should respond_to(:name_element)
        watir_definition.should respond_to(:name_text_field)
      end

      it 'should generate methods for interacting with the text field' do
        watir_definition.should respond_to(:name)
        watir_definition.should respond_to(:name=)
        watir_definition.should respond_to(:name_exists?)
        watir_definition.should respond_to(:name_visible?)
        watir_definition.should respond_to(:name_enabled?)
        watir_definition.should respond_to(:name?)
        watir_definition.should respond_to(:name_?)
        watir_definition.should respond_to(:name!)
        watir_definition.should respond_to(:name_text_field?)
        watir_definition.should respond_to(:name_text_field_?)
        watir_definition.should respond_to(:name_text_field!)
      end
    end

    context 'when used by the watir platform' do
      it 'should locate the text field' do
        watir_browser.should_receive(:text_field).and_return(watir_browser)
        web_element = watir_definition.name_object
        web_element.should_not be_nil
        web_element.should be_instance_of Fluent::WebElements::TextField
      end

      it 'should enter text into a text field' do
        watir_browser.should_receive(:text_field).and_return(watir_browser)
        watir_browser.should_receive(:set).with('testing')
        watir_definition.name = 'testing'
      end

      it 'should retrieve text from the text field' do
        watir_browser.should_receive(:text_field).and_return(watir_browser)
        watir_browser.should_receive(:value).and_return('testing')
        watir_definition.name.should == 'testing'
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