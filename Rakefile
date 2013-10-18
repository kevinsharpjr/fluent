#!/usr/bin/env rake
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new do |config|
  options  = %w(--color)
  options += %w(--format documentation)
  options += %w(--format nested --out output/fluent-test-report.txt)
  options += %w(--format html --out output/fluent-test-report.html)
  config.rspec_opts = options
end

task :default => :spec