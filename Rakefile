# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'
require './lib/gcig_ca125'
require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name = "gcig_ca125"
  gem.homepage = "http://github.com/yatsura/gcig_ca125"
  gem.license = "MIT"
  gem.summary = %Q{Response and progression of ovarian cancer according to serum CA 125 levels}
  gem.description = %Q{ A Ruby gem of calculating the response of Ovarian cancer patient
according to levels of CA 125 as defined by the GCIG}
  gem.email = "paul.d.mitchell@ed.ac.uk"
  gem.authors = ["Paul D Mitchell"]
  gem.version = GcigCa125::Version::STRING
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

task :default => :spec

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "gcig_ca125 #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
