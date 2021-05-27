module Users
  class UpdateLevelWorker < ApplicationWorker
    def perform(user_id)
      user = User.find_by(id: user_id)
      return if user.blank?

      total_points = user.total_points
      new_level = Level.find_by(from: 0..total_points, to: total_points..Float::INFINITY)
      return if new_level.blank?
      return if new_level == user.level

      return unless user.update(level: new_level)

      Notifications::NewLevel.create(user: user, notifiable: Notification::NewLevel.new(level: new_level))
    end
  end
end
