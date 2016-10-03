#!/usr/bin/env ruby

require 'rubygems'
require 'commander/import'

program :name, 'commander-test'
program :version, '0.0.1'
program :description, 'testing commander'

uris = %w[
	http://vision-media.ca
	http://google.com
	http://yahoo.com
]

progress uris do |uri|
	res = open uri
	# Do something with response
end

command :create do |c|
  c.syntax = 'commander-test create [options]'
  c.summary = ''
  c.description = ''
  c.example 'description', 'command example'
  c.option '--some-switch', 'Some switch that does something'
  c.action do |args, options|
    # Do something or c.when_called Commander-test::Commands::Create
  end
end

command :new do |c|
  c.syntax = 'commander-test new [options]'
  c.summary = ''
  c.description = ''
  c.example 'description', 'command example'
  c.option '--some-switch', 'Some switch that does something'
  c.action do |args, options|
    # Do something or c.when_called Commander-test::Commands::New
  end
end

