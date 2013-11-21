require 'spec_helper'

class FormGenerators
  include Fluent

  form :group, id: 'group'
  forms :accounts, id: 'accounts'
end

describe Fluent::Generators do
  let(:watir_browser)    { mock_browser_for_watir }
  let(:watir_definition) { FormGenerators.new(watir_browser) }

  let(:form_object) { double('image_object') }
  let(:form_definition) { Fluent::WebElements::Form.new(form_object, :platform => :watir_webdriver) }
  
  describe 'form generators' do
    context 'when declared on a page definition' do
      it 'should generate methods for referencing the form' do
        watir_definition.should respond_to(:group_object)
        watir_definition.should respond_to(:group_element)
        watir_definition.should respond_to(:group_form)
      end

      it 'should generate methods for interacting with the form' do
        watir_definition.should respond_to(:group_exists?)
        watir_definition.should respond_to(:group_visible?)
        watir_definition.should respond_to(:group?)
        watir_definition.should respond_to(:group_?)
        watir_definition.should respond_to(:group_form_exists?)
        watir_definition.should respond_to(:group_form_visible?)
        watir_definition.should respond_to(:group_form?)
        watir_definition.should respond_to(:group_form_?)
      end

      it 'should generate methods for multiple forms' do
        watir_definition.should respond_to(:accounts_elements)
      end
    end

    context 'when used by the watir platform' do
      it 'should locate the form' do
        watir_browser.should_receive(:form).and_return(watir_browser)
        web_element = watir_definition.group_object
        web_element.should_not be_nil
        web_element.should be_instance_of Fluent::WebElements::Form
      end

      it 'should locate multiple forms' do
        watir_browser.should_receive(:forms).and_return(watir_browser)
        watir_browser.should_receive(:[]).and_return(form_definition)
        watir_browser.should_receive(:map).and_return(watir_browser)
        web_elements = watir_definition.accounts_elements
        web_elements.should_not be_nil
        web_elements[0].should be_instance_of Fluent::WebElements::Form
      end
    end
  end
end