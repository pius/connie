require 'rake'
require 'pathname'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rcov/rcovtask'
require 'spec'
require 'spec/rake/spectask'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "connie"
    s.summary = "TODO"
    s.email = "pius+git@alum.mit.edu"
    s.homepage = "http://github.com/pius/connie"
    s.description = "TODO"
    s.authors = ["Pius Uzamere"]
    #s.add_dependency = 'gecode'
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

Rake::TestTask.new do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'connie'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

Rcov::RcovTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['spec/**/*_spec.rb']
  t.verbose = true
end

task :default => [ :spec ]

desc 'Run specifications'
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_opts << '--options' << 'spec/spec.opts' if File.exists?('spec/spec.opts')
  t.spec_files = Pathname.glob(Pathname.new(__FILE__).dirname + 'spec/**/*_spec.rb')
 
  begin
    t.rcov = ENV.has_key?('NO_RCOV') ? ENV['NO_RCOV'] != 'true' : true
    t.rcov_opts << '--exclude' << 'spec'
    t.rcov_opts << '--text-summary'
    t.rcov_opts << '--sort' << 'coverage' << '--sort-reverse'
  rescue Exception
    # rcov not installed
  end
end
# 
# require 'rubygems'
# require 'spec'
# require 'rake/clean'
# require 'spec/rake/spectask'
# require 'pathname'

# task :default => [ :spec ]
# 
# desc 'Run specifications'
# Spec::Rake::SpecTask.new(:spec) do |t|
#   t.spec_opts << '--options' << 'spec/spec.opts' if File.exists?('spec/spec.opts')
#   t.spec_files = Pathname.glob(Pathname.new(__FILE__).dirname + 'spec/**/*_spec.rb')
#  
#   begin
#     t.rcov = ENV.has_key?('NO_RCOV') ? ENV['NO_RCOV'] != 'true' : true
#     t.rcov_opts << '--exclude' << 'spec'
#     t.rcov_opts << '--text-summary'
#     t.rcov_opts << '--sort' << 'coverage' << '--sort-reverse'
#   rescue Exception
#     # rcov not installed
#   end
# end