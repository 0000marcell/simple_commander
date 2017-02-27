require 'spec_helper'
require 'simple_commander/cli'
require_relative '../helpers/io_helper'
require 'fileutils'

describe IO_helper do
  include IO_helper
  TEST_FILE =
    File.dirname(__FILE__) + '/mock/test.rb'
  TEST_DIR =
    File.dirname(__FILE__) + '/mock'

  before :each do
    FileUtils.touch(TEST_FILE)
  end

  after :each do
    FileUtils.rm(TEST_FILE)
  end

  describe '#in_file?' do
    it "verifies if a string is in the file" do 
      File.open(TEST_FILE, 'w+'){|f| f.write('something!')}
      result = in_file? "something!", TEST_FILE
      expect(result).to eq(true)
    end

    it "return false if a string is not in the file" do
      File.open(TEST_FILE, 'w+'){|f| f.write('asf!')}
      result = in_file? "something!", TEST_FILE
      expect(result).to eq(false)
    end
  end

  describe '#in_file_snippet?' do
    it "verifies if a string is in a file between two tokens" do
      str = <<~HEREDOC
        def this
          something
        end
      HEREDOC
      File.open(TEST_FILE, 'w+'){|f| f.write(str)}
      result = in_file_snippet? "def", "end", "something",
                TEST_FILE
      expect(result).to eq(true)
    end

    it "returns false if the string is somewhere else" do
      str = <<~HEREDOC
        def this
        end
        something
      HEREDOC
      File.open(TEST_FILE, 'w+'){|f| f.write(str)}
      result = in_file_snippet? "def", "end", "something",
                TEST_FILE
      expect(result).to eq(false)
    end
  end

  describe '#find_file' do
    it "verifies if a file name containing a string exists in a dir" do
      result = find_file('te', TEST_DIR)
      expect(result).to eq('test.rb')
    end

    it "returns false if a file was not found" do
      result = find_file('zzz', TEST_DIR)
      expect(result).to eq(false)
    end
  end
end
