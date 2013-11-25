require 'fluent/data_reader'

module Fluent
  module DataBuilder
    extend DataReader

    # http://www.cheezyworld.com/2012/02/23/page-object-0-6-2-released/
    
    class << self
      attr_accessor :data_source
    end
    
    def self.default_data_path
      'common/data'
    end
    
    def data_for(key, data={})
      record = key.to_s
      DataBuilder.load('default.yml')
      
      puts "DataBuilder.data_source = #{DataBuilder.data_source}"
      
      data = DataBuilder.data_source[record]
      raise ArgumentError, "Undefined key for data: #{key}" unless data
      data
    end
    
    alias_method :data_from,       :data_for
    alias_method :data_about,      :data_for
    alias_method :using_data_for,  :data_for
    alias_method :using_data_from, :data_for
    
  end
end