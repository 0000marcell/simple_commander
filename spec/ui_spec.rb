require 'spec_helper'

describe SimpleCommander::UI do
  include SimpleCommander::Methods

  describe '.replace_tokens' do
    it 'should replace tokens within a string, with hash values' do
      result = SimpleCommander::UI.replace_tokens 'Welcome :name, enjoy your :object'.freeze, name: 'TJ', object: 'cookie'
      expect(result).to eq('Welcome TJ, enjoy your cookie')
    end
  end

  describe 'progress' do
    it 'should not die on an empty list' do
      exception = false
      begin
        progress([]) {}
      rescue
        exception = true
      end
      expect(exception).not_to be true
    end
  end

  describe '.available_editor' do
    it 'should not fail on available editors with shell arguments' do
      expect(SimpleCommander::UI.available_editor('sh -c')).to eq('sh -c')
    end
  end
end
