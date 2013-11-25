require 'fluent/data_reader'

module Fluent
  module DataBuilder
    extend DataReader

    # http://www.cheezyworld.com/2012/02/23/page-object-0-6-2-released/
    
    class << self
      attr_accessor :data_
    end
    
    def self.default_data_path
      'common/data'
    end
    
    def using_data_for(key, data={})
    end
    
    # Alias to using_data_from
    
  end
end