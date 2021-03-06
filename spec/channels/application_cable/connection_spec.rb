require 'rails_helper'

RSpec.describe ApplicationCable::Connection, type: :channel do
  it 'successfully connects' do
    user = create(:user)

    connect "/cable?token=#{token_for(user)}"
    expect(connection.current_user).to eq user
  end

  it 'rejects connection' do
    expect { connect '/cable' }.to have_rejected_connection
  end
end
