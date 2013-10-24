require_relative '../spec_helper'

describe 'WebElements::SelectList' do
  let(:select_list_object) { double('select_list_object') }
  let(:select_list_definition) { ::Fluent::WebElements::SelectList.new(select_list_object, :platform => :watir_webdriver) }
  let(:select_list_options) { [select_list_object, select_list_object] }
  
  # select_list_actual == select_list_definition
  
  it 'should determine if an option is selected' do
    select_list_object.stub(:selected?).with('testing').and_return(true)
    select_list_definition.selected?('testing')
  end

  it 'should be able to select an item by option' do
    select_list_object.should_receive(:select).and_return(true)
    select_list_definition.select('testing')
  end

  it 'should be able to select an item by value' do
    select_list_object.should_receive(:select_value).and_return(true)
    select_list_definition.select_value('testing')
  end

  it 'should return an array of selected options' do
    select_list_object.stub(:selected_options).and_return(select_list_options)
    select_list_object.stub(:text).and_return(select_list_object)
    select_list_definition.selected_options.should == select_list_options
  end

  it 'should get the values for any selected options' do
    select_list_object.stub(:selected_options).and_return(select_list_options)
    select_list_object.stub(:value).and_return(select_list_object)
    select_list_definition.selected_values.should == select_list_options
  end

  it 'should determine if an option is available in the list' do
    select_list_object.stub(:include?).with('testing').and_return(true)
    select_list_definition.include?('testing')
  end

  it 'should register with a select list tag' do
    ::Fluent::WebElements.get_class_for(:select).should == ::Fluent::WebElements::SelectList
  end
end