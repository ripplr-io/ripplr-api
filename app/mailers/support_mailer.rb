class SupportMailer < ApplicationMailer
  SUPPORT_EMAIL = 'support@ripplr.io'.freeze

  def new_ticket
    @ticket = params[:ticket]

    @ticket.screenshots.each do |screenshot|
      attachments[screenshot.filename.to_s] = screenshot.download
    end

    mail(to: SUPPORT_EMAIL, subject: "New ticket: #{@ticket.title}", reply_to: @ticket.user.email)
  end

  def account_deleted
    @user = params[:user]
    @comment = params[:comment]
    mail(to: SUPPORT_EMAIL, subject: "#{@user.name} canceled the account")
  end
end
