require 'cocaine'

line = Cocaine::CommandLine.new('echo', "hello 'world'")
p line.command
p line.run
line = Cocaine::CommandLine.new('echo another > testing.txt')
line.run
