require 'spec_helper'

class TestPage01
end

class TestPage02
end

class TestWorkflow
  include Fluent::Workflow
  
  def on(caller)
    caller.new
  end
end

describe Fluent::Workflow do
  before(:each) do
    @test_workflow = TestWorkflow.new
  end
  
  it 'should store the paths' do
    paths = %w(a b c)
    TestWorkflow.paths = {:default => paths}
    TestWorkflow.paths[:default].should == paths
  end

  it 'should fail when it does not find a proper path' do
    TestWorkflow.paths = {:default => ['a'], :testing => ['b']}
    expect { @test_workflow.workflow_for(TestPage02, :using => :no_route) }.to raise_error
  end

  it 'should fail when a method is specified but does not exist' do
    TestWorkflow.paths = [{ :default => [[TestPage01, :a_method], [TestPage02, :b_method]] }]
    mock_page = double('mock_page')
    TestPage01.should_receive(:new).and_return(mock_page)
    mock_page.should_receive(:respond_to?).with(:a_method).and_return(false)
    expect { @test_workflow.workflow_for(TestPage02) }.to raise_error
  end

  it 'should pass arguments to methods when performing the workflow' do
    pages = [[TestPage01, :a_method, 'blah']]
    TestWorkflow.paths = [{:default => pages}]
    TestPage01.should_receive(:new).twice.and_return(TestPage01)
    TestPage01.should_receive(:a_method).with('blah')
    @test_workflow.workflow_for(TestPage01).class.should == Class
  end

end