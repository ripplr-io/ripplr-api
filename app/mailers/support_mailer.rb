class SupportMailer < ApplicationMailer
  SUPPORT_EMAIL = 'support@ripplr.io'.freeze

  def new_ticket(ticket)
    @ticket = ticket

    @ticket.screenshots.each do |screenshot|
      attachments[screenshot.filename.to_s] = screenshot.download
    end

    mail(to: SUPPORT_EMAIL, subject: "New ticket: #{@ticket.title}", reply_to: @ticket.user.email)
  end

  def new_report(user, post, data)
    @user = user
    @data = data
    @post = post
    mail(to: SUPPORT_EMAIL, subject: 'A post has been reported')
  end

  def account_deleted(user, comment)
    @user = user
    @comment = comment
    mail(to: SUPPORT_EMAIL, subject: "#{@user.name} canceled the account")
  end
end
