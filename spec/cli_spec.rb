require 'spec_helper'
require 'simple_commander/cli'

describe SimpleCommander::CLI do
	CONFIG_FILE = 
				File.dirname(__FILE__) + '/../lib/simple_commander/config.yml'

	before :each do
		mock_terminal
		File.open(CONFIG_FILE, 'w+'){ |f| f.write("not empty!") }
	end

	describe 'init' do
		it 'writes the path in to a config file' do
			SimpleCommander::CLI.init
			yml = YAML.load_file(CONFIG_FILE)	
			expect(yml[:path]).to eq(File.expand_path('./'))
		end
	end

	describe 'show config' do
		it 'shows the config file info' do
			SimpleCommander::CLI.show_config
			expect(@output.string).to eq("not empty!\n")
		end
	end
end
