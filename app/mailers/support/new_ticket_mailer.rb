module Support
  class NewTicketMailer < ApiMailer
    template 'd-46830b2e733847868987f734f2173e37'

    def perform(ticket_id)
      ticket = Ticket.find_by(id: ticket_id)
      return if ticket.blank?

      mail.add_personalization(
        to: 'support@ripplr.io',
        data: {
          user_name: ticket.user.profile.name,
          user_email: ticket.user.email,
          reported_at: ticket.created_at.to_i,
          ticket_title: ticket.title,
          ticket_body: ticket.body
        }
      )

      ticket.screenshots.each do |screenshot|
        mail.add_attachment(
          name: screenshot.filename.to_s,
          file: Base64.strict_encode64(screenshot.download)
        )
      end

      mail.reply_to = ticket.user.email

      mail.deliver
    end
  end
end
