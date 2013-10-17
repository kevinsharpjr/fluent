require_relative '../spec_helper'

class CheckboxGenerators
  include Fluent

  checkbox :toggle, id: 'toggle'
end

describe Fluent::Generators do
  let(:watir_browser)    { mock_browser_for_watir }
  let(:watir_definition) { CheckboxGenerators.new(watir_browser) }

  describe 'checkbox generators' do
    context 'when declared on a page definition' do
      it 'should generate methods for referencing the checkbox' do
        watir_definition.should respond_to(:toggle_object)
        watir_definition.should respond_to(:toggle_element)
        watir_definition.should respond_to(:toggle_checkbox)
      end

      it 'should generate methods for interacting with the text checkbox' do
        watir_definition.should respond_to(:toggle_checked?)
        watir_definition.should respond_to(:check_toggle)
        watir_definition.should respond_to(:uncheck_toggle)
        watir_definition.should respond_to(:toggle_exists?)
        watir_definition.should respond_to(:toggle_visible?)
        watir_definition.should respond_to(:toggle_enabled?)
        watir_definition.should respond_to(:toggle?)
        watir_definition.should respond_to(:toggle_?)
        watir_definition.should respond_to(:toggle!)
        watir_definition.should respond_to(:toggle_checkbox?)
        watir_definition.should respond_to(:toggle_checkbox_?)
        watir_definition.should respond_to(:toggle_checkbox!)
      end
    end

    context 'when used by the watir platform' do
      it 'should locate the checkbox' do
        watir_browser.should_receive(:checkbox).and_return(watir_browser)
        web_element = watir_definition.toggle_object
        web_element.should_not be_nil
        web_element.should be_instance_of Fluent::WebElements::CheckBox
      end

      it 'should determine if a checkbox is checked' do
        watir_browser.should_receive(:checkbox).and_return(watir_browser)
        watir_browser.should_receive(:set?).and_return(true)
        watir_definition.toggle_checked?.should be_true
      end

      it 'should be able to check a checkbox' do
        watir_browser.should_receive(:checkbox).and_return(watir_browser)
        watir_browser.should_receive(:set)
        watir_definition.check_toggle
      end

      it 'should be able to uncheck a checkbox' do
        watir_browser.should_receive(:checkbox).and_return(watir_browser)
        watir_browser.should_receive(:clear)
        watir_definition.uncheck_toggle
      end

      it 'should determine if a checkbox exists' do
        watir_browser.should_receive(:checkbox).exactly(3).times.and_return(watir_browser)
        watir_browser.should_receive(:exists?).exactly(3).times.and_return(watir_browser)
        watir_definition.toggle_checkbox_exists?.should be_true
        watir_definition.toggle_exists?.should be_true
        watir_definition.toggle?.should be_true
      end

      it 'should determine if a checkbox is visible' do
        watir_browser.should_receive(:checkbox).exactly(3).times.and_return(watir_browser)
        watir_browser.should_receive(:present?).exactly(3).times.and_return(watir_browser)
        watir_definition.toggle_checkbox_visible?.should be_true
        watir_definition.toggle_visible?.should be_true
        watir_definition.toggle_?.should be_true
      end

      it 'should determine if a checkbox is enabled' do
        watir_browser.should_receive(:checkbox).exactly(3).times.and_return(watir_browser)
        watir_browser.should_receive(:enabled?).exactly(3).times.and_return(watir_browser)
        watir_definition.toggle_checkbox_enabled?.should be_true
        watir_definition.toggle_enabled?.should be_true
        watir_definition.toggle!.should be_true
      end
    end
  end
end