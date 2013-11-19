require 'spec_helper'

describe 'Fluent::WebElements::Form' do

  it 'should register with a form tag' do
    ::Fluent::WebElements.get_class_for(:form).should == ::Fluent::WebElements::Form
  end

end