module Accounts
  class Destroy < ApplicationInteractor
    def call
      data = mailer_data(context.resource)

      context.fail! unless context.resource.destroy

      Support::AccountDeletedMailer.perform_async(data, context.comment)
      Users::AnonymizeWorker.perform_async(context.resource.id)
    end

    private

    def mailer_data(user)
      {
        user_name: user.name,
        user_email: user.email,
        posts_total: user.posts.count,
        points_total: user.total_points,
        joined_at: user.created_at.to_i,
        rates_received_total: user.received_ratings.count,
        rates_given_total: user.ratings.count,
        followers_total: user.followers.count,
        following_total: user.follows.count,
        subscriptions_total: user.subscriptions.count,
        subscribers_total: user.subscribers.count
      }
    end
  end
end