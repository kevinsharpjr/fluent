require 'fluent/data_reader'

module Fluent
  module DataConfigHelper

    # This is being used in order to allow a call to any key in a config
    # file. The key will be treated as a method. Since no such method
    # will exist, the method_missing call will handle finding the key
    # in a file.
    def method_missing(*args, &block)
      determine_data_source unless @data_source
      
      key = args.first

      value = @data_source[key.to_s]
      value = args[1] unless value
      
      value
    end
    
    # Determines what data source to use. If this is being called, it
    # means no data source was specified. If an environment variable
    # has been set, that will be used. If no data source can be
    # established, a default data file will be referenced.
    def determine_data_source
      @data_source = nil
      @data_source = YAML.load_file "#{data_path}/#{ENV['FLUENT_CONFIG_FILE']}" if ENV['FLUENT_CONFIG_FILE']
      
      Fluent::DataConfig.load 'config-data.yml' if @data_source.nil?
    end
    
  end

  module DataConfig
    extend DataReader
    extend DataConfigHelper
    
    class << self
      attr_accessor :data_source
    end
    
    def self.default_data_path
      'common/data'
    end
    
  end

  
end