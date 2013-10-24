require_relative '../spec_helper'

describe 'Fluent::WebElements::TextArea' do

  it 'should register with a text area tag' do
    ::Fluent::WebElements.get_class_for(:textarea).should == ::Fluent::WebElements::TextArea
  end

end