require 'spec_helper'

describe 'Fluent::WebElements::ListItem' do

  it 'should register with a list item tag' do
    ::Fluent::WebElements.get_class_for(:li).should == ::Fluent::WebElements::ListItem
  end

end