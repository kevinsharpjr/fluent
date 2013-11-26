require 'spec_helper'

class RadioGenerators
  include Fluent

  radio :female, name: 'gender'
  radios :group, id: 'group'
end

describe Fluent::Generators do
  let(:watir_browser)    { mock_browser_for_watir }
  let(:watir_definition) { RadioGenerators.new(watir_browser) }

  let(:radio_object) { double('radio_object') }
  let(:radio_definition) { Fluent::WebElements::Radio.new(radio_object, :platform => :watir_webdriver) }

  describe 'radio generators' do
    context 'when declared on a page definition' do
      it 'should generate methods for referencing the radio' do
        watir_definition.should respond_to(:female_object)
        watir_definition.should respond_to(:female_element)
        watir_definition.should respond_to(:female_radio)
      end

      it 'should generate the common actions for checking the radio' do
        watir_definition.should respond_to(:female_exists?)
        watir_definition.should respond_to(:female_visible?)
        watir_definition.should respond_to(:female?)
        watir_definition.should respond_to(:female_?)
        watir_definition.should respond_to(:female_radio?)
        watir_definition.should respond_to(:female_radio_?)
        watir_definition.should respond_to(:female_radio_exists?)
        watir_definition.should respond_to(:female_radio_visible?)
      end
      
      it 'should generate common actions for enabled state' do
        watir_definition.should respond_to(:female_enabled?)
        watir_definition.should respond_to(:female!)
        watir_definition.should respond_to(:female_radio!)
        watir_definition.should respond_to(:female_radio_enabled?)
      end

      it 'should generate specific actions for interacting with the radio' do
        watir_definition.should respond_to(:set_female)
        watir_definition.should respond_to(:female_set?)
        watir_definition.should respond_to(:female_set)
      end

      it 'should generate methods for multiple radios' do
        watir_definition.should respond_to(:group_elements)
      end
    end

    context 'when used by the watir platform' do
      it 'should locate the radio' do
        watir_browser.should_receive(:radio).and_return(watir_browser)
        web_element = watir_definition.female_radio
        web_element.should_not be_nil
        web_element.should be_instance_of Fluent::WebElements::Radio
      end

      it 'should locate multiple radios' do
        watir_browser.should_receive(:radios).and_return(watir_browser)
        watir_browser.should_receive(:[]).and_return(radio_definition)
        watir_browser.should_receive(:map).and_return(watir_browser)
        web_elements = watir_definition.group_elements
        web_elements.should_not be_nil
        web_elements[0].should be_instance_of Fluent::WebElements::Radio
      end

      it 'should determine if a radio is set' do
        watir_browser.should_receive(:radio).and_return(watir_browser)
        watir_browser.should_receive(:set?).and_return(watir_browser)
        watir_definition.female_set?.should be_true
      end

      it 'should set a radio' do
        watir_browser.should_receive(:radio).twice.times.and_return(watir_browser)
        watir_browser.should_receive(:set).twice.times.and_return(watir_browser)
        watir_definition.female_set
        watir_definition.set_female
      end
      
      it 'should determine if a radio exists' do
        watir_browser.should_receive(:radio).exactly(3).times.and_return(watir_browser)
        watir_browser.should_receive(:exists?).exactly(3).times.and_return(watir_browser)
        watir_definition.female_radio_exists?.should be_true
        watir_definition.female_exists?.should be_true
        watir_definition.female?.should be_true
      end

      it 'should determine if a radio is visible' do
        watir_browser.should_receive(:radio).exactly(3).times.and_return(watir_browser)
        watir_browser.should_receive(:present?).exactly(3).times.and_return(watir_browser)
        watir_definition.female_radio_visible?.should be_true
        watir_definition.female_visible?.should be_true
        watir_definition.female_?.should be_true
      end

      it 'should determine if a radio is enabled' do
        watir_browser.should_receive(:radio).exactly(3).times.and_return(watir_browser)
        watir_browser.should_receive(:enabled?).exactly(3).times.and_return(watir_browser)
        watir_definition.female_radio_enabled?.should be_true
        watir_definition.female_enabled?.should be_true
        watir_definition.female!.should be_true
      end
    end
  end
end