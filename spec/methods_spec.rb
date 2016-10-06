require 'spec_helper'
require 'simple_commander/methods'

describe SimpleCommander::Methods do
  it 'includes SimpleCommander::UI' do
    expect(subject.ancestors).to include(SimpleCommander::UI)
  end

  it 'includes SimpleCommander::UI::AskForClass' do
    expect(subject.ancestors).to include(SimpleCommander::UI::AskForClass)
  end

  it 'includes SimpleCommander::Delegates' do
    expect(subject.ancestors).to include(SimpleCommander::Delegates)
  end

  it 'does not change the Object ancestors' do
    expect(Object.ancestors).not_to include(SimpleCommander::UI)
  end
end
