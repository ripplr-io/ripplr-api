module Support
  class NewReportMailer < ApiMailer
    template 'd-d411ada772df468dba44701f43ec79b4'

    def perform(user_id, post_id, reason, body)
      user = User.find_by(id: user_id)
      post = Post.find_by(id: post_id)
      return if user.blank? || post.blank?

      mail.add_personalization(
        to: 'support@ripplr.io',
        data: {
          user_name: user.profile.name,
          user_email: user.email,
          reported_at: Time.current.to_i,
          report_reason: reason,
          report_body: body,
          post_url: app_post_url(post)
        }
      )

      mail.deliver
    end
  end
end
