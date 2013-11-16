#!/usr/bin/env rake
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

namespace :spec do
  RSpec::Core::RakeTask.new(:all) do |config|
    options  = %w(--color)
    options += %w(--format documentation)
    options += %w(--format nested --out spec/reports/fluent-test-report.txt)
    options += %w(--format html --out spec/reports/fluent-test-report.html)
    
    config.pattern = 'spec/**/*_spec.rb'
    config.ruby_opts = '-I lib'
    config.rspec_opts = options
  end
end

task default: %w(spec:all)