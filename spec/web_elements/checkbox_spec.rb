require_relative '../spec_helper'

describe 'WebElements::CheckBox' do
  let(:checkbox_object) { double('checkbox_object') }
  let(:checkbox_definition) { ::Fluent::WebElements::CheckBox.new(checkbox_object, :platform => :watir_webdriver) }

  it 'should be able to determine if the checkbox element is checked' do
    checkbox_object.should_receive(:set?).and_return(true)
    checkbox_definition.checked?
  end

  it 'should be able to check the checkbox' do
    checkbox_object.should_receive(:set)
    checkbox_definition.check
  end

  it 'should be able to uncheck the checkbox' do
    checkbox_object.should_receive(:clear)
    checkbox_definition.uncheck
  end

  it 'should register with a checkbox tag' do
    ::Fluent::WebElements.get_class_for(:input, :checkbox).should == ::Fluent::WebElements::CheckBox
  end
end