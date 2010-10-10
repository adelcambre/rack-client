require 'rubygems'
require 'rake'
require 'rake/gempackagetask'
require 'rake/clean'
require 'rspec/core/rake_task'


$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'rack/client/version'


spec = Gem::Specification.new do |s|
  s.name              = "rack-client"
  s.rubyforge_project = s.name
  s.version           = Rack::Client::VERSION
  s.author            = "Tim Carey-Smith"
  s.email             = "tim" + "@" + "spork.in"
  s.homepage          = "http://github.com/halorgium/rack-client"
  s.summary           = "A client wrapper around a Rack app or HTTP"
  s.description       = s.summary
  s.files             = %w[History.txt LICENSE README.textile Rakefile] + Dir["lib/**/*"] + Dir["demo/**/*"]
  s.test_files        = Dir["spec/**/*"]

  s.add_bundler_dependencies
end

Rake::GemPackageTask.new(spec) do |package|
  package.gem_spec = spec
end

desc 'Install the package as a gem.'
task :install => [:clean, :package] do
  gem = Dir['pkg/*.gem'].first
  sh "sudo gem install --no-rdoc --no-ri --local #{gem}"
end

RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = %w[ -c -f documentation -r ./spec/spec_helper.rb ]
  t.pattern = 'spec/**/*_spec.rb'
end

task :default  => :spec
