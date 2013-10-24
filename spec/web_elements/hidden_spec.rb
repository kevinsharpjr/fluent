require_relative '../spec_helper'

describe 'Fluent::WebElements::Div' do

  it 'should register with a hidden tag' do
    ::Fluent::WebElements.get_class_for(:hidden).should == ::Fluent::WebElements::Hidden
  end

end