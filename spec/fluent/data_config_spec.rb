require 'spec_helper'

describe Fluent::DataConfig do
  
  context 'when configuring the data path' do
    it 'should default to a directory named common' do
      Fluent::DataConfig.data_path.should == 'config'
    end
  end

  context 'when reading data files' do
    it 'should retrieve the data by a key named after the method called' do
      Fluent::DataConfig.data_path = 'conf'
      data_file_mock = double('yaml')
      YAML.should_receive(:load_file).with('conf/test_data_file').and_return(data_file_mock)
      data_file_mock.should_receive(:[]).with('vm_to_run_on').and_return('localhost')
      Fluent::DataConfig.load('test_data_file')
      Fluent::DataConfig.vm_to_run_on.should == 'localhost'
    end
  end
  
end