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

    # Provides a context for an action that will generate a JavaScript prompt
    # message box. The prompt invocation will be overridden by the platform.
    #
    # @param response [String] the value to be used in the prompt
    # @param block [Proc] the code that generates the prompt
    # @return [Hash] :message for the prompt message, :default_value for
    # the value that the prompt had before the response was applied
    def will_prompt(response, &block)
      platform.will_prompt(response, &block)
    end
  end
end