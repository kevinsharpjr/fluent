module Fluent
  module DataReader
    
    def data_path=(path)
      @data_path = path
    end
    
    def data_path
      return @data_path if @data_path
      return default_data_path if self.respond_to? :default_data_path
    end
    
    # A rescue might be good here for situations where the file
    # cannot be found.
    def load(file)
      @data_source = YAML.load_file "#{data_path}/#{file}" 
    end
    
  end
end