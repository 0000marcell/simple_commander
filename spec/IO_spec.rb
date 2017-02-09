require 'spec_helper'
require 'simple_commander/cli'
require 'byebug'
require_relative '../helpers/io_helper'

describe IO_helper do
  TEST_FILE =
    File.dirname(__FILE__) + '/mock/test.rb'

  before :each do
    FileUtils.touch(TEST_FILE)
  end

  after :each do
    FileUtils.rm(TEST_FILE)
  end

  describe '#in_file?' do
    it "verifies if a string is in the file" do 
      File.open(TEST_FILE, 'w+'){|f| f.write('something!')}
      result = in_file? "something", TEST_FILE
      expect(result).to eq(true)
    end
  end
end
