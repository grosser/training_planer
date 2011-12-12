#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rspec-rails' if ['test','development'].include? Rails.env

WebinarPlaner::Application.load_tasks
Dir.glob('app/tasks/*.rake').each { |r| import r }

task(:default).clear
task :default => :spec
