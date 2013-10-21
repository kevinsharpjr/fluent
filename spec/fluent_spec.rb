require 'spec_helper'

describe Fluent do
  
  it 'should return version information' do
    Fluent.version.should == "Fluent v#{Fluent::VERSION}"
  end

  it 'should set the element level wait default to 5' do
    Fluent.instance_variable_set('@element_wait', nil)
    Fluent.element_level_wait.should == 5
  end

  it 'should allow the element level wait to be set' do
    Fluent.instance_variable_set('@element_wait', 10)
    Fluent.element_level_wait.should == 10
  end

  it 'should be able to set an element level wait value' do
    Fluent.element_level_wait = 10
    value = Fluent.instance_variable_get('@element_wait')
    value.should == 10
  end
end