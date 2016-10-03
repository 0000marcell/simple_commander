require 'highline'

cli = HighLine.new
answer = cli.ask "What do you think?"
puts "You have answered: #{answer}"
