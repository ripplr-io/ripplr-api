require 'rails_helper'

RSpec.describe ContentBots::CreateService, type: :service do
  it 'creates a new user' do
    create(:level)
    file = file_fixture('logo.png')
    allow_any_instance_of(URI::HTTPS).to receive(:open).and_return(file.open)

    expect { described_class.new('Bot Name', 'https://url.com/image.png').call }
      .to change { User.count }.by(1)

    expect(User.last.profile.name).to eq('Bot Name')
    expect(User.last.avatar).not_to be(nil)
    expect(User.last.email).to start_with('bot_')
  end
end
