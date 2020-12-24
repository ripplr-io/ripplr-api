# FIXME: Rails will have a CDN proxy in a future version: https://github.com/rails/rails/pull/34477
# In the meantime we're using this solution: https://lipanski.com/posts/activestorage-cdn-rails-direct-route
direct :public_blob do |blob|
  if Rails.env.development? || Rails.env.test?
    route_for(:rails_blob, blob)
  else
    File.join("https://cdn.ripplr.io", blob.key)
  end
end
