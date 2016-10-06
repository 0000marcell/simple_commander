require 'spec_helper'
require 'simple_commander/configure'

describe SimpleCommander do
  describe '.configure' do
    it 'calls the given block' do
      expect { SimpleCommander.configure { throw :block_called } }.to throw_symbol(:block_called)
    end

    describe 'called block' do
      before(:each) do
        allow(SimpleCommander::Runner.instance).to receive(:run!)
      end

      it 'provides Commander configuration methods' do
        SimpleCommander.configure do
          program :name, 'test'
        end

        expect(SimpleCommander::Runner.instance.program(:name)).to eq('test')
      end

      it 'passes all arguments to the block' do
        SimpleCommander.configure('foo') do |first_arg|
          program :name, first_arg
        end

        expect(SimpleCommander::Runner.instance.program(:name)).to eq('foo')
      end
    end

    it 'calls Runner#run! after calling the configuration block' do
      expect(SimpleCommander::Runner.instance).to receive(:run!)
      SimpleCommander.configure {}
    end
  end
end
