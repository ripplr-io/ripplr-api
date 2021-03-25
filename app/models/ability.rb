class Ability
  include CanCan::Ability

  def initialize(user)
    public_access
    return if user.blank?

    authenticated_access(user)
  end

  def public_access
    can :create, :webhook
    can :manage, :welcome
    can :show, Referral

    can :read, Comment
    can :read, Community
    can :read, Follow
    can :read, Hashtag
    can :read, Level
    can :read, Post
    can :read, Topic
    can :read, User
  end

  def authenticated_access(user)
    can :manage, :support
    can :manage, :account
    can :manage, :report
    can :manage, :search
    can :manage, :tracking
    can :manage, :stripe

    can :manage, BookmarkFolder, user_id: user.id
    can :manage, Bookmark, user_id: user.id
    can :manage, Channel, user_id: user.id
    can :manage, Comment, author_id: user.id
    can :manage, Community, owner_id: user.id
    can :manage, Follow, user_id: user.id
    can :manage, Inbox, user_id: user.id
    can :manage, InboxItem, inbox: { user_id: user.id }
    can :manage, InboxChannel, user_id: user.id
    can :manage, Notification, user_id: user.id
    can :manage, Post, author_id: user.id
    can :manage, Rating, user_id: user.id
    can :manage, Referral, inviter_id: user.id
    can :manage, Subscription, user_id: user.id
    can :manage, SubscriptionInbox, inbox: { user_id: user.id }
    can :manage, Ticket, user_id: user.id
  end
end
