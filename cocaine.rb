require 'cocaine'

line = Cocaine::CommandLine.new('echo', "hello 'world'")
p line.command
p line.run

line = Cocaine::CommandLine.new("convert", ":in -scale :resolution :out")
p line.command(in: "omg.jpg",
						 resolution: "32x32",
						 out: "omg_thumb.jpg")
