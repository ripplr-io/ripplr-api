module PasswordValidatable
  def validate_password!
    head :unauthorized unless current_user.valid_password?(params[:current_password])
  end
end
