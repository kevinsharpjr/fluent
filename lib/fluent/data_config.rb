require 'fluent/data_reader'

module Fluent
  module DataConfig
    extend DataReader

    class << self
      attr_accessor :data_source
    end
    
    def self.default_data_path
      'common/data'
    end
    
  end
end