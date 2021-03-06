require 'spec_helper'

class ButtonGenerators
  include Fluent

  button :submit, id: 'submit'
  buttons :navigate, class: 'nav'
end

describe Fluent::Generators do
  let(:watir_browser)    { mock_browser_for_watir }
  let(:watir_definition) { ButtonGenerators.new(watir_browser) }

  let(:button_object) { double('button_object') }
  let(:button_definition) { Fluent::WebElements::Button.new(button_object, :platform => :watir_webdriver) }
  
  describe 'button generators' do
    context 'when declared on a page definition' do
      it 'should generate methods for referencing the button' do
        watir_definition.should respond_to(:submit_object)
        watir_definition.should respond_to(:submit_element)
        watir_definition.should respond_to(:submit_button)
      end

      it 'should generate the common actions for checking the button' do
        watir_definition.should respond_to(:submit_exists?)
        watir_definition.should respond_to(:submit_visible?)
        watir_definition.should respond_to(:submit?)
        watir_definition.should respond_to(:submit_?)
        watir_definition.should respond_to(:submit_button?)
        watir_definition.should respond_to(:submit_button_?)
        watir_definition.should respond_to(:submit_button_exists?)
        watir_definition.should respond_to(:submit_button_visible?)
      end

      it 'should generate common actions for enabled state' do
        watir_definition.should respond_to(:submit_enabled?)
        watir_definition.should respond_to(:submit!)
        watir_definition.should respond_to(:submit_button!)
        watir_definition.should respond_to(:submit_button_enabled?)
      end

      it 'should generate the common action for getting text' do
        watir_definition.should respond_to(:submit_text)
      end

      it 'should generate specific actions for interacting with the button' do
        watir_definition.should respond_to(:submit)
      end

      it 'should generate methods for multiple buttons' do
        watir_definition.should respond_to(:navigate_elements)
      end
    end

    context 'when used by the watir platform' do
      it 'should locate the button' do
        watir_browser.should_receive(:button).and_return(watir_browser)
        web_element = watir_definition.submit_object
        web_element.should_not be_nil
        web_element.should be_instance_of Fluent::WebElements::Button
      end

      it 'should locate multiple buttons' do
        watir_browser.should_receive(:buttons).and_return(watir_browser)
        watir_browser.should_receive(:[]).and_return(button_definition)
        watir_browser.should_receive(:map).and_return(watir_browser)
        web_elements = watir_definition.navigate_elements
        web_elements.should_not be_nil
        web_elements[0].should be_instance_of Fluent::WebElements::Button
      end
      
      it 'should click the button' do
        watir_browser.should_receive(:button).and_return(watir_browser)
        watir_browser.should_receive(:click)
        watir_definition.submit
      end
      
      it 'should get the text from a button' do
        watir_browser.should_receive(:button).and_return(watir_browser)
        watir_browser.should_receive(:text).and_return('Login')
        watir_definition.submit_text.should == 'Login'
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