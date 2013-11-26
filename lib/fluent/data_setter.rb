module Fluent
  module DataSetter
    
    # @param data [Hash] the data to use
    def using(data)
      data.each do |key, value|
        use_select_data_with(key, value) if value_selectable_for(key) and object_enabled_for(key)
        use_check_data_with(key, value)  if value_checkable_for(key)  and object_enabled_for(key)
        use_set_data_with(key, value)    if value_settable_for(key)  and object_enabled_for(key)
        use_text_data_with(key, value)   if text_settable_for(key)    and object_enabled_for(key)
      end
    end
    
    alias_method :using_data,   :using
    alias_method :use_data,     :using
    alias_method :using_values, :using
    alias_method :use_values,   :using
    
    def use_text_data_with(key, value)
      self.send "#{key}_set", value
    end
    
    def use_check_data_with(key, value)
      return self.send "#{key}_check" if value
      return self.send "#{key}_uncheck"
    end
    
    def use_select_data_with(key, value)
      self.send "#{key}_select" if value
    end

    def use_set_data_with(key, value)
      self.send "set_#{key}" if value
    end    
    
    # The _for methods should use a unique signature for referring
    # to a particular element action.
    
    def value_checkable_for(key)
      respond_to?("#{key}_check".to_sym)
    end
    
    # Only a select list can respond to a suffix of 'select_'
    def value_selectable_for(key)
      respond_to?("#{key}_select".to_sym)
    end
    
    # Only a radio can respond to a prefix of 'set_'
    def value_settable_for(key)
      respond_to?("set_#{key}".to_sym)
    end
    
    def text_settable_for(key)
      respond_to?("#{key}=".to_sym)
    end
    
    def object_enabled_for(key)
      web_element = self.send("#{key}_element")
      web_element.enabled? and web_element.visible?
    end
    
  end
end