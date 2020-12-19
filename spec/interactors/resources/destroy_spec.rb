require 'rails_helper'

RSpec.describe Resources::Destroy, type: :interactor do
  it 'saves valid resources' do
    topic = create(:topic)

    result = described_class.call(resource: topic)

    expect(result.success?).to eq(true)
    expect(User.all.count).to eq(0)
  end
end
