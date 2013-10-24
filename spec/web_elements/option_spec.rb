require_relative '../spec_helper'

describe 'Fluent::WebElements::Option' do

  it 'should register with an option tag' do
    ::Fluent::WebElements.get_class_for(:option).should == ::Fluent::WebElements::Option
  end

end