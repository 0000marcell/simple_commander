require 'mixlib/cli'

class MyCLI
	include Mixlib::CLI
	option :config_file,
		:short => "-c CONFIG",
		:long => "--config CONFIG",
		:default => 'config.rb',
		:description => 'the configuration file to use'
end

cli = MyCLI.new
cli.parse_options
puts cli.config[:config_file]
