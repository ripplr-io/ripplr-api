class HashtagChannel < ApplicationCable::Channel
  def subscribed
    hashtag = Hashtag.find_by(id: params[:room])
    stream_for hashtag if hashtag.present?
  end
end
