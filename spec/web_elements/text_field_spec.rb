require_relative '../spec_helper'

describe 'WebElements::TextField' do
  let(:text_field_object) { double('text_field_object') }
  let(:text_field_definition) { ::Fluent::WebElements::TextField.new(text_field_object, :platform => :watir_webdriver) }
  
  it 'should append text to a text field' do
    text_field_object.should_receive(:send_keys).with('testing')
    text_field_definition.append 'testing'
  end

  it 'should set the value of a text field' do
    text_field_object.should_receive(:set).with('testing')
    text_field_definition.value = 'testing'
  end
end