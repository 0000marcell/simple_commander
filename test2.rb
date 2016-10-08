require 'yaml'

yaml = YAML.load_file('config.yml')
puts yaml[:path]
yml = {path: '/Users/marcell', this: 'this', that: 'that'}.to_yaml # 
File.open('config.yml', 'w') do |file|
	file.write(yml)
end
