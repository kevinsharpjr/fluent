require 'spec_helper'

describe Fluent do
  
  it 'should return version information' do
    Fluent.version.should == "Fluent v#{Fluent::VERSION}"
  end
  
end