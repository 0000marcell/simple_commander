require 'yaml'
require 'simple_commander/helpers/io'
require 'byebug'

module SimpleCommander
	class CLI
		include IO_helper
		DEFAULT_PATH = "#{File.dirname(__FILE__)}/config.yml"
		TEMPLATE_PATH = File.expand_path "#{File.dirname(__FILE__)}" + 
																			'/../../templates'
		attr_accessor :config_file

		class UndefinedSCPath < StandardError
			def initialize
				msg = <<-END 
You need to set a path to commander
use simple_commander init <path> or cd to
the folder you want to use an repo for your 
simple commander scripts  and run 
simple_commander init
				END
				super(msg)
			end
		end
		
		def initialize(path=DEFAULT_PATH)
			@config_file = path
		end

		def init(path='./')
			if path
				local_path = File.expand_path(path)
			else
				local_path = File.expand_path('./')
			end

			yml = { path: local_path }.to_yaml
			File.open(@config_file, 'w+'){|f| f.write(yml)}
		end

		def show_config
			raise UndefinedSCPath if !File.file?(@config_file)
			say YAML.load_file(@config_file)
		end

		def new(*args)
			sc_path = YAML.load_file(@config_file)[:path]
			raise UndefinedSCPath if !sc_path
			s_path = "#{sc_path}/#{args[0]}"
			raise StandardError "program #{args[0]} already exists!"  if File.directory?(s_path)
			@program_name = args[0]
			mkdir s_path 
			mkdir "#{s_path}/bin"
			mkdir "#{s_path}/spec"
			mkdir "#{s_path}/lib"
			mkdir "#{s_path}/lib/#{@program_name}"
			template "#{TEMPLATE_PATH}/lib.erb",
				"#{s_path}/lib/#{@program_name}.rb"

			template "#{TEMPLATE_PATH}/version.erb",
				"#{s_path}/lib/#{@program_name}/version.rb"

			template "#{TEMPLATE_PATH}/bin.erb",
				"#{s_path}/bin/#{@program_name}"
		end
	end
end
