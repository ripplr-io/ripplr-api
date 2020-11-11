module Notifications
  class NewFollower < Notification
    attr_accessor :follower

    before_validation :set_data

    private

    def set_data
      return if @follower.nil?

      self.data = {
        type: type.split('::').last.underscore,
        author_id: @follower.id
      }
    end
  end
end
