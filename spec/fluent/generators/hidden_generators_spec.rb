require 'spec_helper'

class HiddenGenerators
  include Fluent

  hidden :ssn, id: 'ssn'
  hiddens :post, id: 'posts'
end

describe Fluent::Generators do
  let(:watir_browser)    { mock_browser_for_watir }
  let(:watir_definition) { HiddenGenerators.new(watir_browser) }

  let(:hidden_object) { double('hidden_object') }
  let(:hidden_definition) { Fluent::WebElements::Hidden.new(hidden_object, :platform => :watir_webdriver) }

  describe 'hidden generators' do
    context 'when declared on a page definition' do
      it 'should generate methods for referencing the hidden' do
        watir_definition.should respond_to(:ssn_object)
        watir_definition.should respond_to(:ssn_element)
        watir_definition.should respond_to(:ssn_hidden)
      end

      it 'should generate methods for interacting with the text area' do
        watir_definition.should respond_to(:ssn)
        watir_definition.should respond_to(:ssn_exists?)
        watir_definition.should respond_to(:ssn_visible?)
        watir_definition.should respond_to(:ssn?)
        watir_definition.should respond_to(:ssn_?)
        watir_definition.should respond_to(:ssn_hidden_exists?)
        watir_definition.should respond_to(:ssn_hidden_visible?)
        watir_definition.should respond_to(:ssn_hidden?)
        watir_definition.should respond_to(:ssn_hidden_?)
      end

      it 'should generate methods for multiple hidden fields' do
        watir_definition.should respond_to(:post_elements)
      end
    end

    context 'when used by the watir platform' do
      it 'should locate the hidden' do
        watir_browser.should_receive(:hidden).and_return(watir_browser)
        web_element = watir_definition.ssn_object
        web_element.should_not be_nil
        web_element.should be_instance_of Fluent::WebElements::Hidden
      end

      it 'should locate multiple hidden fields' do
        watir_browser.should_receive(:hiddens).and_return(watir_browser)
        watir_browser.should_receive(:[]).and_return(hidden_definition)
        watir_browser.should_receive(:map).and_return(watir_browser)
        web_elements = watir_definition.post_elements
        web_elements.should_not be_nil
        web_elements[0].should be_instance_of Fluent::WebElements::Hidden
      end

      it 'should retrieve text from the hidden' do
        watir_browser.should_receive(:hidden).and_return(watir_browser)
        watir_browser.should_receive(:value).and_return('testing')
        watir_definition.ssn.should == 'testing'
      end
    end
  end
end