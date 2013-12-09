require 'spec_helper'

describe Fluent::DataBuilder do
  
  context 'when configuring the data path' do
    before(:each) do
      Fluent::DataBuilder.data_path = nil
    end
    
    it 'should default to a directory named common' do
      Fluent::DataBuilder.data_path.should == 'data'
    end

    it 'should store a data source directory' do
      Fluent::DataBuilder.data_path = 'config/data'
      Fluent::DataBuilder.data_path.should == 'config/data'
    end
  end

  context 'when reading data files' do
    let(:watir_browser) { mock_browser_for_watir }
    
    it 'should read files from the data path directory' do
      Fluent::DataBuilder.data_path = 'config/data'
      YAML.should_receive(:load_file).with('config/data/test_data_file').and_return({})
      Fluent::DataBuilder.load('test_data_file')
    end

    it 'loads the correct data file from the default' do
      Fluent::DataBuilder.data_path = 'spec'
      class QuickDefinition
        include Fluent
      end
      data = QuickDefinition.new(watir_browser).data_for 'valid'
      expect(data.keys.sort).to eq(['bank','name'])
    end
  end
  
  context 'when provided a file' do
    let(:watir_browser) { mock_browser_for_watir }
    
    it 'loads the correct data file and retrieves data' do
      Fluent::DataBuilder.data_path = 'spec'
      class QuickDefinition
        include Fluent
      end
      data = QuickDefinition.new(watir_browser).data_for 'mock_data/valid'
      expect(data.keys.sort).to eq(['bank','name'])
    end
  end
  
end