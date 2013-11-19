require 'spec_helper'

describe 'Fluent::WebElements::Div' do

  it 'should register with a div tag' do
    ::Fluent::WebElements.get_class_for(:div).should == ::Fluent::WebElements::Div
  end
  
end