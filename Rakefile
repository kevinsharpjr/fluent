#!/usr/bin/env rake
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new do |config|
  options  = %w(--color)
  options += %w(--format documentation)
  config.rspec_opts = options
end

task :default => :spec