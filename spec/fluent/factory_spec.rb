require 'spec_helper'
require 'mock_app'

class TestFactory
  include Fluent::Factory

  attr_accessor :driver
end

class DefinitionTest
  include Fluent

  url_is 'http://localhost:9292'
end

class DefinitionTest2
  include Fluent

  url_is 'http://google.com'
end

describe Fluent::Factory do
  before(:each) do
    @factory = TestFactory.new
    @factory.driver = mock_browser_for_watir
  end
  
  it 'should create a new definition object and view it, using on_view' do
    @factory.driver.should_receive(:goto)
    @factory.on_view DefinitionTest do |page|
      page.should be_instance_of DefinitionTest
    end
  end

  it 'should create a new definition object, using on' do
    @factory.driver.should_not_receive(:goto)
    @factory.on DefinitionTest do |page|
      page.should be_instance_of DefinitionTest
    end
  end
  
  it 'should create a new definition object, using on_new' do
    @factory.driver.should_not_receive(:goto)
    @factory.on_new DefinitionTest do |page|
      page.should be_instance_of DefinitionTest
    end
  end
  
  it 'should create a new definition object, using on_set' do
    @factory.driver.should_not_receive(:goto)
    @factory.on_set DefinitionTest do |page|
      page.should be_instance_of DefinitionTest
    end
  end
  
  it 'should use an existing object reference with on' do
    @factory.driver.should_receive(:goto)
    obj1 = @factory.on_view DefinitionTest
    obj2 = @factory.on DefinitionTest
    obj1.should == obj2
  end
  
  it 'should not use an existing object reference with on_new' do
    @factory.driver.should_receive(:goto)
    obj1 = @factory.on_view DefinitionTest
    obj2 = @factory.on_new DefinitionTest
    obj1.should_not == obj2
  end
  
  it 'should use an existing object reference with on_set' do
    @factory.driver.should_receive(:goto)
    obj1 = @factory.on_view DefinitionTest
    obj2 = @factory.on_set DefinitionTest
    obj1.should == obj2
  end
  
  it 'should use an existing context using on after using on_set' do
    obj1 = @factory.on_set DefinitionTest
    obj2 = @factory.on DefinitionTest2
    obj3 = @factory.on DefinitionTest
    
    obj1.should_not == obj2
    obj1.should == obj3
  end
  
  it 'should use an existing context using on_new of different class after using on_set' do
    obj1 = @factory.on_set DefinitionTest
    obj2 = @factory.on_new DefinitionTest2
    obj3 = @factory.on DefinitionTest
    
    obj1.should_not == obj2
    obj1.should == obj3
  end
  
  it 'should clear existing context using on_new after using on_set' do
    obj1 = @factory.on_set DefinitionTest
    obj2 = @factory.on_new DefinitionTest
    obj1.should_not == obj2
  end
  
  it 'should set a reference to be used outside the factory' do
    active = @factory.on DefinitionTest
    current = @factory.instance_variable_get '@active'
    current.should === active
  end
  
  it 'should create a new definition based on a string' do
    @factory.driver.should_receive(:goto)
    @factory.on_view 'DefinitionTest' do |page|
      page.should be_instance_of DefinitionTest
    end
  end
  
end