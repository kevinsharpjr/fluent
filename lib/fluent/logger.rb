module Fluent
  def self.trace(message, level=1)
    puts('*' * level + " #{message}") if ENV['FLUENT_TRACE'] == 'on'
  end
end