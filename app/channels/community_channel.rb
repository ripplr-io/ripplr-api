class CommunityChannel < ApplicationCable::Channel
  def subscribed
    community = Community.find_by(id: params[:room])
    stream_for community if community.present?
  end
end
