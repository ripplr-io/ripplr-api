require 'rails_helper'

RSpec.describe Inboxes::FilterService, type: :service do
  context '#allowed_topics' do
    context 'settings is blank' do
      it 'returns all topics' do
        topic = create(:topic)
        other_topic = create(:topic)

        inbox = create(:inbox, settings: {
          topics: {}
        }.as_json)

        allowed_topics = described_class.new(inbox).send(:allowed_topics)

        expect(allowed_topics).to include(topic)
        expect(allowed_topics).to include(other_topic)
      end
    end

    context 'settings value is only' do
      it 'only returns listed topics' do
        topic = create(:topic)
        other_topic = create(:topic)

        inbox = create(:inbox, settings: {
          topics: {
            value: 'only',
            only: [topic.id]
          }
        }.as_json)

        allowed_topics = described_class.new(inbox).send(:allowed_topics)

        expect(allowed_topics).to include(topic)
        expect(allowed_topics).not_to include(other_topic)
      end
    end

    context 'settings value is except' do
      it 'returns all topics except the listed ones' do
        topic = create(:topic)
        other_topic = create(:topic)

        inbox = create(:inbox, settings: {
          topics: {
            value: 'except',
            except: [topic.id]
          }
        }.as_json)

        allowed_topics = described_class.new(inbox).send(:allowed_topics)

        expect(allowed_topics).to include(other_topic)
        expect(allowed_topics).not_to include(topic)
      end
    end

    context 'settings value is followed' do
      it 'only returns followed topics' do
        topic = create(:topic)
        other_topic = create(:topic)

        inbox = create(:inbox, settings: {
          topics: {
            value: 'followed'
          }
        }.as_json)

        create(:follow, user: inbox.user, followable: topic)

        allowed_topics = described_class.new(inbox).send(:allowed_topics)

        expect(allowed_topics).to include(topic)
        expect(allowed_topics).not_to include(other_topic)
      end
    end

    context 'settings value is something else' do
      it 'returns all topics' do
        topic = create(:topic)
        other_topic = create(:topic)

        inbox = create(:inbox, settings: {
          topics: {
            value: 'all'
          }
        }.as_json)

        allowed_topics = described_class.new(inbox).send(:allowed_topics)

        expect(allowed_topics).to include(topic)
        expect(allowed_topics).to include(other_topic)
      end
    end
  end

  context '#allowed_topic?' do
    context 'the topic is included in allowed_topics' do
      it 'returns true' do
        topic = create(:topic)
        inbox = create(:inbox)

        result = described_class.new(inbox).allowed_topic?(topic)

        expect(result).to be(true)
      end
    end

    context 'the topic is not included in allowed_topics' do
      it 'returns true' do
        topic = create(:topic)
        inbox = create(:inbox, settings: {
          topics: {
            value: 'followed'
          }
        }.as_json)

        result = described_class.new(inbox).allowed_topic?(topic)

        expect(result).to be(false)
      end
    end
  end

  context '#allowed_communities' do
    context 'settings is blank' do
      it 'returns all communities' do
        community = create(:community)
        other_community = create(:community)

        inbox = create(:inbox, settings: {
          communities: {}
        }.as_json)

        allowed_communities = described_class.new(inbox).send(:allowed_communities)

        expect(allowed_communities).to include(community)
        expect(allowed_communities).to include(other_community)
      end
    end

    context 'settings value is only' do
      it 'only returns listed communities' do
        community = create(:community)
        other_community = create(:community)

        inbox = create(:inbox, settings: {
          communities: {
            value: 'only',
            only: [community.id]
          }
        }.as_json)

        allowed_communities = described_class.new(inbox).send(:allowed_communities)

        expect(allowed_communities).to include(community)
        expect(allowed_communities).not_to include(other_community)
      end
    end

    context 'settings value is except' do
      it 'returns all communities except the listed ones' do
        community = create(:community)
        other_community = create(:community)

        inbox = create(:inbox, settings: {
          communities: {
            value: 'except',
            except: [community.id]
          }
        }.as_json)

        allowed_communities = described_class.new(inbox).send(:allowed_communities)

        expect(allowed_communities).to include(other_community)
        expect(allowed_communities).not_to include(community)
      end
    end

    context 'settings value is followed' do
      it 'only returns followed communities' do
        community = create(:community)
        other_community = create(:community)

        inbox = create(:inbox, settings: {
          communities: {
            value: 'followed'
          }
        }.as_json)

        create(:follow, user: inbox.user, followable: community)

        allowed_communities = described_class.new(inbox).send(:allowed_communities)

        expect(allowed_communities).to include(community)
        expect(allowed_communities).not_to include(other_community)
      end
    end

    context 'settings value is something else' do
      it 'returns all communities' do
        community = create(:community)
        other_community = create(:community)

        inbox = create(:inbox, settings: {
          communities: {
            value: 'all'
          }
        }.as_json)

        allowed_communities = described_class.new(inbox).send(:allowed_communities)

        expect(allowed_communities).to include(community)
        expect(allowed_communities).to include(other_community)
      end
    end
  end

  context '#allowed_community?' do
    context 'the community is included in allowed_communities' do
      it 'returns true' do
        community = create(:community)
        inbox = create(:inbox)

        result = described_class.new(inbox).allowed_community?(community)

        expect(result).to be(true)
      end
    end

    context 'the community is not included in allowed_communities' do
      it 'returns true' do
        community = create(:community)
        inbox = create(:inbox, settings: {
          communities: {
            value: 'followed'
          }
        }.as_json)

        result = described_class.new(inbox).allowed_community?(community)

        expect(result).to be(false)
      end
    end
  end
end
