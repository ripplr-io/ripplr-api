module ContentBots
  class CreateService
    def initialize(name, avatar_url, content_sources = [])
      @name = name
      @avatar_url = avatar_url
      @content_sources = content_sources
    end

    def call
      bot = User.new(
        name: @name,
        avatar_url: @avatar_url,
        email: generate_email,
        password: generate_password
      )

      Accounts::Create.call(resource: bot)
    end

    private

    def generate_email
      random_string = Devise.friendly_token.first(10)
      "bot_#{random_string}@ripplr.io"
    end

    def generate_password
      Devise.friendly_token.first(8)
    end
  end
end
