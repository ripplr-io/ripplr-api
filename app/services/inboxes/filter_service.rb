module Inboxes
  class FilterService
    def initialize(inbox)
      @inbox = inbox
    end

    def allowed_topic?(topic)
      allowed_topics.find_by(id: topic.id).present?
    end

    private

    def allowed_topics
      all_topics = Topic.all
      followed_topics = @inbox.user.following_topics

      settings = @inbox.settings['topics']

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
  end
end
