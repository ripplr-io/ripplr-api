require 'rails_helper'

RSpec.describe Resources::DestroyService, type: :service do
  it 'raises NotImplementedError on destroy' do
    topic = build(:topic)

    service = described_class.new(topic)

    expect { service.destroy }.to raise_error(NotImplementedError)
  end
end
