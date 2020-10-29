require 'rails_helper'

RSpec.describe Resources::CreateService, type: :service do
  it 'raises NotImplementedError on save' do
    topic = build(:topic)

    service = described_class.new(topic)

    expect { service.save }.to raise_error(NotImplementedError)
  end
end
