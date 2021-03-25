module InboxChannels
  class UserValidator < ActiveModel::Validator
    def validate(record)
      return if record.user.blank?
      return if same_user?(record)

      record.errors.add(:user, 'must be the same')
    end

    private

    def same_user?(record)
      user = record.user
      inbox_user = record.inbox&.user
      channel_user = record.channel&.user

      user == inbox_user && user == channel_user
    end
  end
end
