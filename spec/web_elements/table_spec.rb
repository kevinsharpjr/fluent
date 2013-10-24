require_relative '../spec_helper'

describe 'Fluent::WebElements::Table' do

  it 'should register with a table tag' do
    ::Fluent::WebElements.get_class_for(:table).should == ::Fluent::WebElements::Table
  end

end