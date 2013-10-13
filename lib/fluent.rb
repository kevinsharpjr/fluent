require 'fluent/version'

module Fluent
  
  def self.version
    "Fluent v#{Fluent::VERSION}"
  end

  # The included callback is used to provide the core functionality of the
  # library to any class or module that includes the Fluent library. The
  # calling class or module is extended with logic that the library makes
  # available as class methods. Those classes become page definitions or
  # activity definitions.
  #
  # @param caller [Class] the class including the library
  def self.included(caller)
    puts 'Fluent has been included.'
  end
  
end
