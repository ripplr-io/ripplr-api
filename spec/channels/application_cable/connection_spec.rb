require 'rails_helper'

RSpec.describe ApplicationCable::Connection, type: :channel do
  it 'successfully connects' do
    user = create(:user)
    token = JWT.encode({ sub: user.id }, Rails.application.credentials.secret_key_base)

    connect "/cable?token=#{token}"
    expect(connection.current_user).to eq user
  end

  it 'rejects connection' do
    expect { connect '/cable' }.to have_rejected_connection
  end
end
