require 'fluent'

ENV['FLUENT_TRACE'] = 'on'

@driver = Watir::Browser.new :firefox

# Fluent is a module that can be included into Ruby classes. When that is
# done, those classes become page or activity definitions. Fluent will
# then add functionality to any object created from that class. The
# functionality adds various classes and methods that you can use to
# define and interact with applications.

class Stardate
  include Fluent

  url_is 'http://localhost:9292/stardate'
  title_is 'Stardate Calculator | Fluency'
end

page = Stardate.new(@driver)
page.view
page.check_url
page.check_title