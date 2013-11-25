require 'spec_helper'

describe Fluent::DataBuilder do
  
  context 'when configuring the data path' do
    it 'should default to a directory named common' do
      Fluent::DataBuilder.data_path.should == 'common/data'
    end

    it 'should store a data source directory' do
      Fluent::DataBuilder.data_path = 'config/data'
      Fluent::DataBuilder.data_path.should == 'config/data'
    end
  end

  context 'when reading data files' do
    it 'should read files from the data path directory' do
      Fluent::DataBuilder.data_path = 'config/data'
      YAML.should_receive(:load_file).with('config/data/test_data_file').and_return({})
      Fluent::DataBuilder.load('test_data_file')
    end
  end
  
end