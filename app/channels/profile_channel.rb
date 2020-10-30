class ProfileChannel < ApplicationCable::Channel
  def subscribed
    user = User.find_by(id: params[:room])
    stream_for user if user.present?
  end
end
