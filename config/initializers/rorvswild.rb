RorVsWild.start(api_key: Rails.application.credentials.dig(:rorvswild_token)) if Rails.env.production?
