module Support
  class ContentSuggestionsController < ApplicationController
    load_resource :topic
    authorize_resource class: :support

    def create
      content_suggestion = ContentSuggestionForm.new(content_suggestion_params)
      return render_errors(content_suggestion.errors) unless content_suggestion.valid?

      user = "#{content_suggestion.user.name} <#{content_suggestion.user.email}>"
      bot = "#{content_suggestion.name} (#{content_suggestion.url}, #{content_suggestion.topic.name})"

      Slack::NotifyService.new.ping("#{user} has suggested a new bot: #{bot}", '#marketing')
      head :no_content
    end

    private

    def content_suggestion_params
      params.permit(:name, :url).merge(user: current_user, topic: @topic)
    end
  end
end
