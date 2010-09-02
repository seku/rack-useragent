require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Run all tests'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "rack-useragent-filter"
    gemspec.authors = ["Tomasz Mazur", "Sergio Gil", "Luismi Cavallé"]
    gemspec.email = "defkode@gmail.com"
    gemspec.homepage = "http://github.com/defkode/rack-useragent"
    gemspec.summary = "Rack Middleware for filtering by user agent"
    gemspec.add_dependency('rack', '>= 0.9.1')
    gemspec.add_dependency('useragent', '>= 0.1.5')
    gemspec.add_dependency('tilt', '>= 1.0.0')
  end
rescue LoadError
end
