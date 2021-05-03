require 'rails_helper'

RSpec.describe Trackers::TrackFollowCreatedWorker, type: :worker do
  context 'Followable is a user' do
    it 'calls the service' do
      follow = create(:follow, followable: create(:profile))

      expect(Analytics).to receive(:track).with(
        follow.user,
        'Follow Created',
        { 'Followable type' => 'Profile' }
      )

      described_class.new.perform(follow.id)
    end
  end

  context 'Followable is a topic' do
    it 'calls the service' do
      follow = create(:follow, followable: create(:topic))

      expect(Analytics).to receive(:track).with(
        follow.user,
        'Follow Created',
        { 'Followable type' => 'Topic' }
      )

      described_class.new.perform(follow.id)
    end
  end

  context 'Followable is a hashtag' do
    it 'calls the service' do
      follow = create(:follow, followable: create(:hashtag))

      expect(Analytics).to receive(:track).with(
        follow.user,
        'Follow Created',
        { 'Followable type' => 'Hashtag' }
      )

      described_class.new.perform(follow.id)
    end
  end

  context 'Followable is a community' do
    it 'calls the service' do
      follow = create(:follow, followable: create(:community))

      expect(Analytics).to receive(:track).with(
        follow.user,
        'Follow Created',
        { 'Followable type' => 'Community' }
      )

      described_class.new.perform(follow.id)
    end
  end
end
