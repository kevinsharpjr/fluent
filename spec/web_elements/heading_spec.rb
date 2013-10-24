require_relative '../spec_helper'

describe 'Fluent::WebElements::Heading' do

  it 'should register with a h1 tag' do
    ::Fluent::WebElements.get_class_for(:h1).should == ::Fluent::WebElements::Heading
  end

  it 'should register with a h2 tag' do
    ::Fluent::WebElements.get_class_for(:h2).should == ::Fluent::WebElements::Heading
  end

  it 'should register with a h3 tag' do
    ::Fluent::WebElements.get_class_for(:h3).should == ::Fluent::WebElements::Heading
  end

  it 'should register with a h4 tag' do
    ::Fluent::WebElements.get_class_for(:h4).should == ::Fluent::WebElements::Heading
  end

  it 'should register with a h5 tag' do
    ::Fluent::WebElements.get_class_for(:h5).should == ::Fluent::WebElements::Heading
  end

  it 'should register with a h6 tag' do
    ::Fluent::WebElements.get_class_for(:h6).should == ::Fluent::WebElements::Heading
  end
end