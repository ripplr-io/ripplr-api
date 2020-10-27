module Notifications
  class NewLevel < Notification
    before_validation :set_data

    private

    def set_data
      return if user.nil?

      self.data = {
        type: type.split('::').last.underscore,
        id: user.id
        # level: @user.level.as_json # TODO: Add level to users
      }
    end
  end
end
