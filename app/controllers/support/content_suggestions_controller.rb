module Support
  class ContentSuggestionsController < ApplicationController
    authorize_resource class: :support

    def create
      content_suggestion = ContentSuggestionForm.new(content_suggestion_params)
      content_suggestion.user = current_user
      content_suggestion.topic = Topic.find_by(id: params[:topic_id])
      return render_errors(content_suggestion.errors) unless content_suggestion.valid?

      user = "#{content_suggestion.user.name} <#{content_suggestion.user.name}>"
      bot = "#{content_suggestion.name} (#{content_suggestion.url}, #{content_suggestion.topic.name})"

      Slack::NotifyService.new.ping("#{user} has suggested a new bot: #{bot}", '#marketing')
      head :no_content
    end

    private

    def content_suggestion_params
      params.permit(:name, :url)
    end
  end
end
