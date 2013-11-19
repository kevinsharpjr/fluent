require 'spec_helper'

describe 'Fluent::WebElements::TextArea' do
  let(:text_area_object) { double('text_area_object') }
  let(:text_area_definition) { ::Fluent::WebElements::TextArea.new(text_area_object, :platform => :watir_webdriver) }
  
  it 'should register with a text area tag' do
    ::Fluent::WebElements.get_class_for(:textarea).should == ::Fluent::WebElements::TextArea
  end

  it 'should get the value of a text area' do
    text_area_object.should_receive(:value).and_return('testing')
    text_area_definition.value.should == 'testing'
  end
  
  it 'should set the value of a text area' do
    text_area_object.should_receive(:set).with('testing')
    text_area_definition.value = 'testing'
  end

  it 'should clear the text area' do
    text_area_object.should_receive(:wd).and_return(text_area_object)
    text_area_object.should_receive(:clear).and_return(true)
    text_area_definition.clear
  end
  
end