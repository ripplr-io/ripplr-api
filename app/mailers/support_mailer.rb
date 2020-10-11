class SupportMailer < ApplicationMailer
  def new_ticket
    @ticket = params[:ticket]

    @ticket.screenshots.each do |screenshot|
      attachments[screenshot.filename.to_s] = screenshot.download
    end

    mail(to: 'support@ripplr.io', subject: "New ticket: #{@ticket.title}")
  end

  def account_deleted
    @user = params[:user]
    @comment = params[:comment]
    mail(to: 'support@ripplr.io', subject: "#{@user.email} canceled the account")
  end
end
