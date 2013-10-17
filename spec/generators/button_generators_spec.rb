require_relative '../spec_helper'

class ButtonGenerators
  include Fluent

  button :submit, id: 'submit'
end

describe Fluent::Generators do
  let(:watir_browser)    { mock_browser_for_watir }
  let(:watir_definition) { ButtonGenerators.new(watir_browser) }

  describe 'button generators' do
    context 'when declared on a page definition' do
      it 'should generate methods for referencing the button' do
        watir_definition.should respond_to(:submit_object)
        watir_definition.should respond_to(:submit_element)
        watir_definition.should respond_to(:submit_button)
      end

      it 'should generate methods for interacting with the button' do
        watir_definition.should respond_to(:submit)
        watir_definition.should respond_to(:submit_exists?)
        watir_definition.should respond_to(:submit_visible?)
        watir_definition.should respond_to(:submit_enabled?)
        watir_definition.should respond_to(:submit?)
        watir_definition.should respond_to(:submit_?)
        watir_definition.should respond_to(:submit!)
        watir_definition.should respond_to(:submit_button_exists?)
        watir_definition.should respond_to(:submit_button_visible?)
        watir_definition.should respond_to(:submit_button_enabled?)
        watir_definition.should respond_to(:submit_button?)
        watir_definition.should respond_to(:submit_button_?)
        watir_definition.should respond_to(:submit_button!)
      end
    end

    context 'when used by the watir platform' do
      it 'should locate the button' do
        watir_browser.should_receive(:button).and_return(watir_browser)
        web_element = watir_definition.submit_object
        web_element.should_not be_nil
        web_element.should be_instance_of Fluent::WebElements::Button
      end

      it 'should click the button' do
        watir_browser.should_receive(:button).and_return(watir_browser)
        watir_browser.should_receive(:click)
        watir_definition.submit
      end

      it 'should determine if a button exists' do
        watir_browser.should_receive(:button).exactly(3).times.and_return(watir_browser)
        watir_browser.should_receive(:exists?).exactly(3).times.and_return(watir_browser)
        watir_definition.submit?.should be_true
        watir_definition.submit_exists?.should be_true
        watir_definition.submit_button_exists?.should be_true
      end

      it 'should determine if a button is visible' do
        watir_browser.should_receive(:button).exactly(3).times.and_return(watir_browser)
        watir_browser.should_receive(:present?).exactly(3).times.and_return(watir_browser)
        watir_definition.submit_?.should be_true
        watir_definition.submit_visible?.should be_true
        watir_definition.submit_button_visible?.should be_true
      end

      it 'should determine if a button is enabled' do
        watir_browser.should_receive(:button).exactly(3).times.and_return(watir_browser)
        watir_browser.should_receive(:enabled?).exactly(3).times.and_return(watir_browser)
        watir_definition.submit!.should be_true
        watir_definition.submit_enabled?.should be_true
        watir_definition.submit_button_enabled?.should be_true
      end
    end
  end
end