require 'rails_helper'

RSpec.describe Tickets::CreateService, type: :service do
  it 'creates the ticket' do
    ticket_params = {
      title: 'Title',
      body: 'Body',
      user: create(:user)
    }

    expect { described_class.new(ticket_params).save }
      .to change { Ticket.count }.by(1)

    # FIXME: verify params
    expect(Sidekiq::Worker.jobs.size).to eq 1
  end
end