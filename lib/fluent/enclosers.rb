module Fluent
  module Enclosers
    
    def will_alert(&block)
      platform.will_alert(&block)
    end
    
  end
end