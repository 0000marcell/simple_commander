


program :name, 'helpers_example'
program :version, '0.0.1'
program :description, 'using IO!'
helpers 'IO' # using the IO helper

command :create do
	command "project folders" do # declaring a multi-lined command
		action 'create some folders using IO helper' do
			mk_dir 'bin' # this is just ruby works in any OS 
			mk_dir 'lib'
			copy 'somefile.rb', './bin/myfile.rb' 
      cp 'another_one', './bin/another.rb' # you can also use cp 
		end
	end
end

# terminal 

> helpers_example create project folders
