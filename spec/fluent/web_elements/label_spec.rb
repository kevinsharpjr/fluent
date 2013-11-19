require 'spec_helper'

describe 'Fluent::WebElements::Div' do

  it 'should register with a label tag' do
    ::Fluent::WebElements.get_class_for(:label).should == ::Fluent::WebElements::Label
  end

end