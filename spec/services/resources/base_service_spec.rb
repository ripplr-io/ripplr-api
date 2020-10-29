require 'rails_helper'

RSpec.describe Resources::BaseService, type: :service do
  it 'assigns the resource' do
    topic = build(:topic)

    service = described_class.new(topic)

    expect(service.resource).to eq(topic)
  end

  it 'delegates the errors' do
    topic = build(:topic, avatar: nil)
    topic.valid?

    service = described_class.new(topic)

    expect(topic.errors.size).to eq(1)
    expect(service.errors).to eq(topic.errors)
  end
end
