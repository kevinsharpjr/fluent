require 'spec_helper'
require 'mock_app'

class TestFactory
  include Fluent::Factory

  attr_accessor :browser
end

class DefinitionTest
  include Fluent

  url_is 'http://localhost:9292'
end

describe Fluent::Factory do
  before(:each) do
    @factory = TestFactory.new
    @factory.browser = mock_browser_for_watir
  end
  
  it 'should create a new definition object and view it, using on_view' do
    @factory.browser.should_receive(:goto)
    @factory.on_view DefinitionTest do |page|
      page.should be_instance_of DefinitionTest
    end
  end

  it 'should create a new definition object, using on' do
    @factory.browser.should_not_receive(:goto)
    @factory.on DefinitionTest do |page|
      page.should be_instance_of DefinitionTest
    end
  end
  
  it 'should set a reference to be used outside the factory' do
    active = @factory.on DefinitionTest
    current = @factory.instance_variable_get '@active'
    current.should === active
  end
  
end