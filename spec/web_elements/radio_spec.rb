require_relative '../spec_helper'

describe 'WebElements::Radio' do
  let(:radio_object) { double('radio_object') }
  let(:radio_definition) { ::Fluent::WebElements::Radio.new(radio_object, :platform => :watir_webdriver) }

  it 'should be able to see if a radio is selected' do
    radio_object.should_receive(:set?).and_return(true)
    radio_definition.selected?
  end

  it 'should be able to select a radio' do
    radio_object.should_receive(:set).and_return(true)
    radio_definition.select
  end

  it 'should be able to clear a radio' do
    radio_object.should_receive(:clear).and_return(true)
    radio_definition.clear
  end
end