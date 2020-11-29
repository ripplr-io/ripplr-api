require 'rails_helper'

RSpec.describe Tickets::CreateService, type: :service do
  it 'creates the ticket' do
    ticket = build(:ticket)

    expect { described_class.new(ticket).save }
      .to change { Ticket.count }.by(1)

    expect(Sidekiq::Queues['mailers'].size).to eq 1
  end
end
