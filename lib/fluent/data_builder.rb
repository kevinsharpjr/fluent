require 'fluent/data_reader'

module Fluent
  module DataBuilder
    extend DataReader
    
    class << self
      attr_accessor :data_source
    end
    
    def self.default_data_path
      'data'
    end
    
    def data_for(key, specified={})
      if key.is_a?(String) && key.match(%r{/})
        file, record = key.split('/')
        DataBuilder.load("#{file}.yml")
      else
        record = key.to_s
        DataBuilder.load('default.yml') #unless DataBuilder.data_source
      end

      Fluent::trace("DataBuilder.data_source = #{DataBuilder.data_source}")
      
      data = DataBuilder.data_source[record]
      raise ArgumentError, "Undefined key for data: #{key}" unless data
      
      data.merge(specified)
    end
    
    alias_method :data_from,       :data_for
    alias_method :data_about,      :data_for
    alias_method :using_data_for,  :data_for
    alias_method :using_data_from, :data_for
    
  end
end