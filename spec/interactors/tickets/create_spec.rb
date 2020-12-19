require 'rails_helper'

RSpec.describe Tickets::Create, type: :interactor do
  it 'creates the ticket' do
    ticket = build(:ticket)

    expect { described_class.call(resource: ticket) }
      .to change { Ticket.count }.by(1)

    expect(Sidekiq::Queues['mailers'].size).to eq 1
  end
end
