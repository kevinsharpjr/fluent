require 'spec_helper'

class RadioGenerators
  include Fluent

  radio :female, name: 'gender'
end

describe Fluent::Generators do
  let(:watir_browser)    { mock_browser_for_watir }
  let(:watir_definition) { RadioGenerators.new(watir_browser) }

  describe 'radio generators' do
    context 'when declared on a page definition' do
      it 'should generate methods for referencing the radio' do
        watir_definition.should respond_to(:female_object)
        watir_definition.should respond_to(:female_element)
        watir_definition.should respond_to(:female_radio)
      end

      it 'should generate methods for interacting with the radio' do
        watir_definition.should respond_to(:select_female)
        watir_definition.should respond_to(:set_female)
        watir_definition.should respond_to(:female_set?)
        watir_definition.should respond_to(:female_selected?)
        watir_definition.should respond_to(:female_exists?)
        watir_definition.should respond_to(:female_visible?)
        watir_definition.should respond_to(:female_enabled?)
        watir_definition.should respond_to(:female?)
        watir_definition.should respond_to(:female_?)
        watir_definition.should respond_to(:female!)
        watir_definition.should respond_to(:female_radio?)
        watir_definition.should respond_to(:female_radio_?)
        watir_definition.should respond_to(:female_radio!)
      end
    end

    context 'when used by the watir platform' do
      it 'should locate the radio' do
        watir_browser.should_receive(:radio).and_return(watir_browser)
        web_element = watir_definition.female_radio
        web_element.should_not be_nil
        web_element.should be_instance_of Fluent::WebElements::Radio
      end

      it 'should determine if a radio is set' do
        watir_browser.should_receive(:radio).twice.and_return(watir_browser)
        watir_browser.should_receive(:set?).twice.and_return(watir_browser)
        watir_definition.female_selected?.should be_true
        watir_definition.female_set?.should be_true
      end

      it 'should set a radio' do
        watir_browser.should_receive(:radio).twice.and_return(watir_browser)
        watir_browser.should_receive(:set).twice.and_return(watir_browser)
        watir_definition.select_female
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