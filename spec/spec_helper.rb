require 'simplecov'

SimpleCov.start

SimpleCov.at_exit do
  SimpleCov.result.format!
  SimpleCov.minimum_coverage 90
  SimpleCov.maximum_coverage_drop 5
end

require 'fluent'