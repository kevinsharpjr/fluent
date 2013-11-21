require 'spec_helper'

class LabelGenerators
  include Fluent

  label :topic, id: 'topic'
  labels :fields, id: 'fields'
end

describe Fluent::Generators do
  let(:watir_browser)    { mock_browser_for_watir }
  let(:watir_definition) { LabelGenerators.new(watir_browser) }

  let(:label_object) { double('label_object') }
  let(:label_definition) { Fluent::WebElements::Label.new(label_object, :platform => :watir_webdriver) }
  
  describe 'label generators' do
    context 'when declared on a page definition' do
      it 'should generate methods for referencing the label' do
        watir_definition.should respond_to(:topic_object)
        watir_definition.should respond_to(:topic_element)
        watir_definition.should respond_to(:topic_label)
      end

      it 'should generate methods for interacting with the label' do
        watir_definition.should respond_to(:topic)
        watir_definition.should respond_to(:topic_exists?)
        watir_definition.should respond_to(:topic_visible?)
        watir_definition.should respond_to(:topic?)
        watir_definition.should respond_to(:topic_?)
        watir_definition.should respond_to(:topic_label_exists?)
        watir_definition.should respond_to(:topic_label_visible?)
        watir_definition.should respond_to(:topic_label?)
        watir_definition.should respond_to(:topic_label_?)
      end

      it 'should generate methods for multiple labels' do
        watir_definition.should respond_to(:fields_elements)
      end
    end

    context 'when used by the watir platform' do
      it 'should locate the label' do
        watir_browser.should_receive(:label).and_return(watir_browser)
        web_element = watir_definition.topic_object
        web_element.should_not be_nil
        web_element.should be_instance_of Fluent::WebElements::Label
      end

      it 'should retrieve text from the label' do
        watir_browser.should_receive(:label).and_return(watir_browser)
        watir_browser.should_receive(:text).and_return('testing')
        watir_definition.topic.should == 'testing'
      end

      it 'should locate multiple labels' do
        watir_browser.should_receive(:labels).and_return(watir_browser)
        watir_browser.should_receive(:[]).and_return(label_definition)
        watir_browser.should_receive(:map).and_return(watir_browser)
        web_elements = watir_definition.fields_elements
        web_elements.should_not be_nil
        web_elements[0].should be_instance_of Fluent::WebElements::Label
      end
    end
  end
end