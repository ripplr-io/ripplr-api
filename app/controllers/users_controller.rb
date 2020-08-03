class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def legacy_show
    redirect_to "/auth/users/#{current_user.id}"
  end

  def show
    user = User.first
    render json: {data: {
      id: user.id,
      slug: "ggraca",
      name: "Guilherme Graca",
      avatar: "https://ripplr.ams3.digitaloceanspaces.com/user/048758bd-51fd-4ad5-9615-ccefd0ba7205/d1ebef2c-f576-40da-ab8f-39c075772621.jpg",
      bio: nil,
      supporter: 0,
      pointsSum: 0,
      followersCount: 0,
      followingCount: 0,
      postsCount: 0,
      level: {
        id: 0,
        name: 'Level 1',
        from: 0,
        to: 250,
        posts: 3,
        referrals: 3,
        subscriptions: 3,
        segments: 0
      },
      accountInfo: {
        email: "guilherme@ripplr.io",
        country: nil,
        timezone: "Europe/Lisbon",
        password_updated_at: user.created_at,
        postsToday: 0
      }
    }}
  end

  def create
  end

  def update
  end

  def destroy
  end
end
