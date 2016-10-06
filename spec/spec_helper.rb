require 'rubygems'
require 'stringio'
require 'simplecov'
require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

SimpleCov.start do
  add_filter '/spec/'
end



# Unshift so that local files load instead of something in gems
$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'

# This basically replicates the behavior of `require 'simple_commander/import'`
# but without adding an `at_exit` hook, which interferes with exit code
require 'simple_commander'
require 'simple_commander/methods'

# Mock terminal IO streams so we can spec against them

def mock_terminal
  @input = StringIO.new
  @output = StringIO.new
  $terminal = HighLine.new @input, @output
end

# Create test command for usage within several specs

def create_test_command
  command :test do
    syntax = 'test [options] <file>'
    description = 'test description'
    example 'description', 'command'
    example 'description 2', 'command 2'
    option '-v', '--verbose', 'verbose description'
    when_called do |args, _options|
      format('test %s', args.join)
    end
  end
  @command = command :test
end

# Create a new command runner

def new_command_runner(*args, &block)
  SimpleCommander::Runner.instance_variable_set :"@singleton", SimpleCommander::Runner.new(args)
  program :name, 'test'
  program :version, '1.2.3'
  program :description, 'something'
  create_test_command
  yield if block
  SimpleCommander::Runner.instance
end

# Comply with how specs were previously written

def command_runner
  SimpleCommander::Runner.instance
end

def run(*args)
  new_command_runner(*args) do
    program :help_formatter, SimpleCommander::HelpFormatter::Base
  end.run!
  @output.string
end

RSpec.configure do |c|
  c.expect_with(:rspec) do |e|
    e.syntax = :expect
  end

  c.mock_with(:rspec) do |m|
    m.syntax = :expect
  end

  c.before(:each) do
    allow(SimpleCommander::UI).to receive(:enable_paging)
  end
end
