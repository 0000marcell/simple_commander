require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

desc 'Run spec'
RSpec::Core::RakeTask.new do |t|
	t.verboce = false
	t.rspec_opts = '--color --order random'
end

RuboCop::RakeTask.new

task default: [:spec, :rubocop]
