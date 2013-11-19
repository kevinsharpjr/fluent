require 'spec_helper'

describe 'Fluent::WebElements::Button' do

  it 'should register with a submit tag' do
    ::Fluent::WebElements.get_class_for(:input, :submit).should == ::Fluent::WebElements::Button
  end

  it 'should register with a button tag' do
    ::Fluent::WebElements.get_class_for(:input, :button).should == ::Fluent::WebElements::Button
  end

  it 'should register with a image tag' do
    ::Fluent::WebElements.get_class_for(:input, :image).should == ::Fluent::WebElements::Button
  end

  it 'should register with a reset tag' do
    ::Fluent::WebElements.get_class_for(:input, :reset).should == ::Fluent::WebElements::Button
  end
  
end