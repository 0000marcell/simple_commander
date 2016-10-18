require 'yaml'
require 'byebug'
yml = YAML.load_file('./config.yml')
if(yml.key?('path'))
	puts 'obj have key'
else
	puts 'obj dont have key'
end
