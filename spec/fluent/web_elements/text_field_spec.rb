require 'spec_helper'

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

  it 'should get the value of a text field' do
    text_field_object.should_receive(:value).and_return('testing')
    text_field_definition.value.should == 'testing'
  end
  
  it 'should register with a text tag' do
    ::Fluent::WebElements.get_class_for(:input, :text).should == ::Fluent::WebElements::TextField
  end

  it 'should register with a password tag' do
    ::Fluent::WebElements.get_class_for(:input, :password).should == ::Fluent::WebElements::TextField
  end
end