require 'rails_helper'

RSpec.describe Resources::Save, type: :interactor do
  it 'saves valid resources' do
    topic = build(:topic)

    result = described_class.call(resource: topic)

    expect(result.success?).to eq(true)
    expect(result.resource).to eq(topic)
    expect(topic).to eq(Topic.last)
  end

  it 'does not save invalid resources' do
    topic = build(:topic, avatar: nil)

    result = described_class.call(resource: topic)

    expect(result.success?).to eq(false)
    expect(result.resource.errors.size).to eq(1)
  end
end
