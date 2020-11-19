module Users
  class UpdateLevelWorker
    include Sidekiq::Worker

    def perform(user_id)
      user = User.find_by(id: user_id)
      return if user.blank?

      # NOTE: force any cache reset to recalculate points
      user.touch

      total_points = user.total_points
      new_level = Level.find_by(from: 0..total_points, to: total_points..Float::INFINITY)
      return if new_level.blank?
      return if new_level == user.level

      Notifications::NewLevel.create(user: user) if user.update(level: new_level)
    end
  end
end
