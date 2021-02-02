module Account
  class ResetPasswordInstructionsMailer < ApiMailer
    template 'd-a2f8ac3963e4485686e9a314d5fd9a2f'

    def perform(user_id, token)
      user = User.find_by(id: user_id)
      return if user.blank?

      mail.add_personalization(
        to: user.email,
        data: {
          email: user.email,
          password_reset_url: app_password_reset_url(token)
        }
      )

      mail.deliver
    end
  end
end
