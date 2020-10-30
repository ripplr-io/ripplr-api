class TopicChannel < ApplicationCable::Channel
  def subscribed
    topic = Topic.find_by(id: params[:room])
    stream_for topic if topic.present?
  end
end
