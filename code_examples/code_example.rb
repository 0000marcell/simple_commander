# myprogram.rb 

program :name, 'myprogram'
program :version, '0.0.1'
program :description, 'example!'

command :show do

  # nest as many subcommands as you want 
  # or define a multi-lined command
	command :greetings do
    # define syntax and description to show when calling --help
    syntax      'myprogram show greetings' 
    description 'say hi!'

    # define as many actions as you want 
    # the actions will be fired sequentially just like
    # in thor's group
		action 'show hi on the terminal' do |args, options|
			say "hi!" 
		end
	end
end

# using on the terminal 

> myprogram show greetings 

> hi!
