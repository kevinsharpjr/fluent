require_relative '../spec_helper'

describe 'Fluent::WebElements::OrderedList' do

  it 'should register with a ordered list tag' do
    ::Fluent::WebElements.get_class_for(:ol).should == ::Fluent::WebElements::OrderedList
  end

end