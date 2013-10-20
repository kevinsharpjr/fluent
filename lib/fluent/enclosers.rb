module Fluent
  module Enclosers

    # Provides a context for an action that will generate a JavaScript alert
    # message box. The alert invocation will be overridden by the platform.
    #
    # @param block [Proc] the code that generates the alert
    # @return [String] the message contained in the alert message box
    def will_alert(&block)
      platform.will_alert(&block)
    end

    # Provides a context for an action that will generate a JavaScript
    # confirmation message box. The confirmation invocation will be
    # overridden by the platform.
    #
    # @param response [Boolean] true to accept the confirmation, false to cancel it
    # @param block [Proc] the code that generates the confirmation
    # @return [String] the message contained in the confirmation message box
    def will_confirm(response, &block)
      platform.will_confirm(response, &block)
    end
    
  end
end