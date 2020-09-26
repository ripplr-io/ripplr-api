# TODO: Make this available in staging and review apps
if Rails.env.development?
  namespace :db do
    desc 'Setup and populate the database with sample data'
    task prime: ['db:setup', 'db:sample']

    desc 'Populate the database with sample data'
    task sample: [
      :users,
      :posts,
      :comments,
      :ratings,
      :hashtags,
      :follows,
      :notifications,
      :devices,
      :subscriptions,
      :tickets,
      :bookmarks
    ].map { |task| "db:sample:#{task}" }
  end
end
