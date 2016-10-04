#!/usr/bin/env ruby

require 'commander-altered/import'

program :name, 'ember-c'
program :version, '0.0.1'
program :description, 'implementing ember with modified commander'

command :new do |c|
	c.syntax = 'ember-c new <name>'
	c.summary = 'create a new ember project'
	c.description = 'Create a new ember project'
	c.example ''
end
