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
      #puts "@data_source = #{@data_source}"

      value = @data_source[key.to_s]
      value = args[1] unless value
      
      #puts "value = #{value}"
      #puts "args[1] = #{args[1]}"
      
      value
    end
    
    def determine_data_source
      @data_source = nil
      @data_source = YAML.load_file "#{data_path}/#{ENV['FLUENT_CONFIG_FILE']}" if ENV['FLUENT_CONFIG_FILE']
      
      #puts "Data path: #{data_path}"
      #puts "Data source: #{@data_source}"
      
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