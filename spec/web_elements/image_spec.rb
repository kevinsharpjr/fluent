require_relative '../spec_helper'

describe 'Fluent::WebElements::Image' do

  it 'should register with a image tag' do
    ::Fluent::WebElements.get_class_for(:img).should == ::Fluent::WebElements::Image
  end

end