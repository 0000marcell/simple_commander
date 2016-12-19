# -*- encoding: utf-8 -*-
$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'simple_commander/version'

Gem::Specification.new do |s|
	s.name        = 'simple_commander'
  s.version     = SimpleCommander::VERSION
  s.authors     = ['Marcell Monteiro Cruz']
  s.email       = ['0000marcell@gmail.com']
  s.license     = 'MIT'
  s.homepage    = 'https://github.com/0000marcell/simple_commander'
  s.summary     = 'Command line framework based on commander and inspired by GLI Thor and others...'
	s.files       = `git ls-files`.split("\n")
	s.test_files  = `git ls-files -- {test, spec, features}/*`.split("\n")
	s.executables = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
	s.require_paths = ['lib'] 
	s.license     = 'MIT'
	s.add_runtime_dependency('highline', '~> 1.7.2')
  s.add_runtime_dependency('colorized', '~> 0.8.1')
	s.add_development_dependency('rspec', '~> 3.2')
  s.add_development_dependency('rake')
  s.add_development_dependency('simplecov')
  s.add_development_dependency('rubocop', '~> 0.29.1')
end
