require_relative '../spec_helper'

class FormGenerators
  include Fluent

  form :group, id: 'group'
end

describe Fluent::Generators do
  let(:watir_browser)    { mock_browser_for_watir }
  let(:watir_definition) { FormGenerators.new(watir_browser) }

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
    end

    context 'when used by the watir platform' do
      it 'should locate the form' do
        watir_browser.should_receive(:form).and_return(watir_browser)
        web_element = watir_definition.group_object
        web_element.should_not be_nil
        web_element.should be_instance_of Fluent::WebElements::Form
      end
    end
  end
end