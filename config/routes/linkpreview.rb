direct :linkpreview do |url|
  proxy_url = 'https://api.linkpreview.net'
  key = Rails.application.credentials[:linkpreview_key]
  query = CGI::escape url

  "#{proxy_url}?key=#{key}&q=#{query}"
end
