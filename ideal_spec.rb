require 'magni'
require 'magni_something'

cli :magni, '--version' do 
	helpers :io, :http
	
	command :create, '-v' do
		syntax = "commander init [option]"
		command :cli, :name, '-a' do
			arg[:name]
			opts[:a]
			task 'create folders' do
				# do stuff here
			end

			task 'copy files' do
				# do stuff here
			end
		end	

		include magni_something
	end
end
