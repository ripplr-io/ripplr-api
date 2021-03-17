require 'rails_helper'

RSpec.describe Attachments::FetchImageService, type: :service do
  it 'sends a message to a channel' do
    file = file_fixture('logo.png')
    allow_any_instance_of(URI::HTTPS).to receive(:open).and_return(file.open)

    data = described_class.new('https://url.com/image.png').call
    expect(data[:io]).not_to be(nil)
    expect(data[:filename]).to eq('image.png')
  end
end
