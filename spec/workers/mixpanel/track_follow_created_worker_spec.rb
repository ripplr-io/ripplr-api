require 'rails_helper'

RSpec.describe Mixpanel::TrackFollowCreatedWorker, type: :worker do
  context 'Followable is a user' do
    it 'calls the mixpanel service' do
      follow = create(:follow, followable: create(:user))

      expect(Mixpanel::BaseService).to receive(:new).with(follow.user).and_call_original
      expect_any_instance_of(Mixpanel::BaseService).to receive(:track).with(
        'Follow Created',
        { 'Followable type' => 'User' }
      )

      described_class.new.perform(follow.id)
    end
  end

  context 'Followable is a topic' do
    it 'calls the mixpanel service' do
      follow = create(:follow, followable: create(:topic))

      expect(Mixpanel::BaseService).to receive(:new).with(follow.user).and_call_original
      expect_any_instance_of(Mixpanel::BaseService).to receive(:track).with(
        'Follow Created',
        { 'Followable type' => 'Topic' }
      )

      described_class.new.perform(follow.id)
    end
  end

  context 'Followable is a hashtag' do
    it 'calls the mixpanel service' do
      follow = create(:follow, followable: create(:hashtag))

      expect(Mixpanel::BaseService).to receive(:new).with(follow.user).and_call_original
      expect_any_instance_of(Mixpanel::BaseService).to receive(:track).with(
        'Follow Created',
        { 'Followable type' => 'Hashtag' }
      )

      described_class.new.perform(follow.id)
    end
  end

  context 'Followable is a community' do
    it 'calls the mixpanel service' do
      follow = create(:follow, followable: create(:community))

      expect(Mixpanel::BaseService).to receive(:new).with(follow.user).and_call_original
      expect_any_instance_of(Mixpanel::BaseService).to receive(:track).with(
        'Follow Created',
        { 'Followable type' => 'Community' }
      )

      described_class.new.perform(follow.id)
    end
  end
end
