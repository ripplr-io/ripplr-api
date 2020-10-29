require 'rails_helper'

RSpec.describe Resources::UpdateService, type: :service do
  it 'assigns attributes to the resource' do
    topic = build(:topic)

    service = described_class.new(topic, { name: 'Business' })

    expect(service.resource.name).to eq('Business')
  end

  it 'raises NotImplementedError on save' do
    topic = build(:topic)

    service = described_class.new(topic, { name: 'Business' })

    expect { service.save }.to raise_error(NotImplementedError)
  end
end
