require 'spec_helper'

describe 'Fluent::WebElements::Cell' do

  it 'should register with a table definition tag' do
    ::Fluent::WebElements.get_class_for(:td).should == ::Fluent::WebElements::Cell
  end

  it 'should register with a table header tag' do
    ::Fluent::WebElements.get_class_for(:th).should == ::Fluent::WebElements::Cell
  end

end