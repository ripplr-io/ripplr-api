module Support
  class AccountDeletedMailer < ApiMailer
    template 'd-70de35e6e4ee44cfada474b906c65b63'

    def perform(user_data, comment)
      mail.add_personalization(
        to: 'support@ripplr.io',
        data: user_data.merge({ comment: comment })
      )

      mail.deliver
    end
  end
end
