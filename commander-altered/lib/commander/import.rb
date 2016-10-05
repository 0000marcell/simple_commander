require 'byebug'
require_relative '../commander.rb'

include Commander::Methods

at_exit { run! }
