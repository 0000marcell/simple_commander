require 'magni'
require 'magni_something'

cli :magni, '--version' do 

	command :create, '-v' do

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
