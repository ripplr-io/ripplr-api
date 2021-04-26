class ProfileChannel < ApplicationCable::Channel
  def subscribed
    profile = Profile.find_by(id: params[:room])
    stream_for profile if profile.present?
  end
end
