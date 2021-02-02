class DeviseProxyMailer < Devise::Mailer
  def reset_password_instructions(record, token, _opts = {})
    Account::ResetPasswordInstructionsMailer.perform_async(record.id, token)
  end
end
