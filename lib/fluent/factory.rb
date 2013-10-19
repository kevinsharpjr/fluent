module Fluent
  module Factory
    
    def on(definition, visit=false, &block)
      puts "ON: browser = #{@browser}; active = #{@active}; platform = #{@platform}"
      active_browser = :watir if @browser.nil?
      
      #browser = Watir::Browser.new if @browser.nil? or @browser == :watir
      #@browser = Selenium::WebDriver.for :firefox if @browser == :selenium
      #@browser = Watir::Browser.new if not @browser.kind_of?(Watir::Browser)
      
      return @active if @active.kind_of?(definition)
      #@active = definition.new(@browser, visit)
      @active = definition.new(@browser, visit)
      block.call @active if block
      @active
    end

    alias_method :on_page, :on
    alias_method :while_on, :on
    
    def on_view(definition, &block)
      #puts "ON_VIEW: browser = #{@browser}; active = #{@active}; platform = #{@platform}"
      on(definition, true, &block)
    end

    alias_method :on_visit, :on_view
    
  end
end