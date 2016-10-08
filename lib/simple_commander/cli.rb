require 'yaml'

module SimpleCommander
	module CLI
		CONFIG_PAH = "#{File.dirname(__FILE__)}/config.yml"
		class UndefinedSCPath < StandardError
			def initialize
				msg = <<-END 
					You need to set a path to commander
					use simple_commander init <path> or cd to
					the folder you want and just simple_commander init
				END
				super(msg)
			end
		end

		def self.init(*args)
			if args[0]
				local_path = File.expand_path(args[0])
			else
				local_path = File.expand_path('./')
			end

			yml = { path: local_path }.to_yaml
			File.open(CONFIG_PATH, 'w+'){|f| f.write(yml)}
		end

		def self.show_config
			say YAML.load_file(CONFIG_PATH)
		end

		def self.new(*args)
			sc_path = YAML.load_file(CONFIG_PATH)[:path]
			s_path = "#{sc_path}/#{args[0]}"
			raise UndefinedSCPath if !sc_path 
			raise StandardError, ""  if File
			if File.directory?(s_path)
				say "The script #{args[0]} already exist!"
				return
			end
			mkdir s_path 
			mkdir "#{s_path}/bin"
			mkdir "#{s_path}/spec"
		end
	end
end
