module Inboxes
  class FilterService
    def initialize(inbox)
      @inbox = inbox
    end

    def allowed_topic?(topic)
      allowed_topics.find_by(id: topic.id).present?
    end

    def allowed_community?(community)
      allowed_communities.find_by(id: community.id).present?
    end

    private

    def allowed_topics
      all_topics = Topic.all
      followed_topics = @inbox.user.following_topics

      settings = @inbox.settings['topics']
      return all_topics if settings.blank?

      case settings['value']
      when 'only'
        all_topics.where(id: settings['only'])
      when 'except'
        all_topics.where.not(id: settings['except'])
      when 'followed'
        followed_topics
      else # NOTE: by default, any other value will behave as 'all'
        all_topics
      end
    end

    def allowed_communities
      all_communities = Community.all
      followed_communities = @inbox.user.following_communities

      settings = @inbox.settings['communities']
      return all_communities if settings.blank?

      case settings['value']
      when 'only'
        all_communities.where(id: settings['only'])
      when 'except'
        all_communities.where.not(id: settings['except'])
      when 'followed'
        followed_communities
      else # NOTE: by default, any other value will behave as 'all'
        all_communities
      end
    end
  end
end
