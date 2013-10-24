require_relative '../spec_helper'

describe 'Fluent::WebElements::Paragraph' do

  it 'should register with a paragraph tag' do
    ::Fluent::WebElements.get_class_for(:p).should == ::Fluent::WebElements::Paragraph
  end

end