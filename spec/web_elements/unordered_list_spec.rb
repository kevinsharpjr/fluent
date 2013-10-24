require_relative '../spec_helper'

describe 'Fluent::WebElements::UnorderedList' do

  it 'should register with a unordered list tag' do
    ::Fluent::WebElements.get_class_for(:ul).should == ::Fluent::WebElements::UnorderedList
  end

end