module Fluent
  module Evaluators

    ## Browser-Level Actions ##
    
    def url
      platform.url
    end

    def remove_cookies
      platform.remove_cookies
    end

    def refresh
      platform.refresh
    end

    def run_script(script)
      platform.run_script(script)
    end

    def screenshot(file)
      platform.screenshot file
    end
    
    alias_method :current_url, :url
    alias_method :clear_cookies, :remove_cookies
    alias_method :refresh_page, :refresh
    alias_method :execute_script, :run_script
    alias_method :save_screenshot, :screenshot
    
    ## Page-Level Actions ##
    
    def markup
      platform.markup
    end
    
    def title
      platform.title
    end

    def text
      platform.text
    end

    def wait_for_app(value=1)
      sleep value
    end
    
    # Attempts to wait for pending jQuery requests and indicate if the
    # requests did not occur in a given time period.
    #
    # @param time_limit [Numeric] time to wait for the block to return true
    # @param message_if_timeout [String] the message to include with the error
    def wait_for_pending_requests(time_limit=30, message_if_timeout=nil)
      end_time = ::Time.now + time_limit
      until ::Time.now > end_time
        return if browser.execute_script('return jQuery.active') == 0
        wait_for_app 0.5
      end
      message = 'Pending jQuery requests never indicated completion.' unless message_if_timeout
      raise message
    end
    
    alias_method :html, :markup
    alias_method :page_title, :title
    alias_method :page_text, :text 
  end
end