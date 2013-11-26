require 'spec_helper'

describe 'Fluent::WebElements::Link' do

  it 'should register with a anchor tag' do
    ::Fluent::WebElements.get_class_for(:a).should == ::Fluent::WebElements::Link
  end

end