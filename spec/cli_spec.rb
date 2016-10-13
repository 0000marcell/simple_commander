require 'spec_helper'
require 'simple_commander/cli'
require 'byebug'

describe SimpleCommander::CLI do
	CONFIG_FILE = 
				File.dirname(__FILE__) + '/mock/config.yml'

	before :each do
		mock_terminal
	end

	after :each do
		if(File.file?(CONFIG_FILE))
			FileUtils.rm(CONFIG_FILE)
		end
	end

	describe '#init' do
		it 'writes the path in to a config file' do
			cli = SimpleCommander::CLI.new(CONFIG_FILE)
			cli.init
			yml = YAML.load_file(CONFIG_FILE)	
			expect(yml[:path].empty?).to eq(false)
		end
	end

	describe '#show_config' do
		it 'shows the config file info' do
			cli = SimpleCommander::CLI.new(CONFIG_FILE)
			cli.init
			cli.show_config
			expect(@output.string.empty?).to eq(false)
		end
	end

	describe '#new' do
		it 'raise error create a new program without initializing the path' do
			path = File.dirname(__FILE__) + 
				'/mock/config_without_path.yml'
			cli = SimpleCommander::CLI.new(path)
			expect do 
				cli.new('ex_program')
			end.to raise_error(SimpleCommander::CLI::UndefinedSCPath)
		end

		it 'raise error when creating program that already exists' do
			expect{ SimpleCommander::CLI.new('ex_progam') }.to 
				raise_error(SimpleCommander::CLI::UndefinedSCPath)
		end

		it 'creates new folders for the program' do
			SimpleCommander::CLI.new('test_program')
			expect(File.directory?('./spec/mock/test_program')).to
				eq (true)
		end
	end
end
