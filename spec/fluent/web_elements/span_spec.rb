require 'spec_helper'

describe 'Fluent::WebElements::Span' do

  it 'should register with a span tag' do
    ::Fluent::WebElements.get_class_for(:span).should == ::Fluent::WebElements::Span
  end

end