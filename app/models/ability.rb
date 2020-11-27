# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    public_access
    return if user.blank?

    authenticated_access(user)
  end

  def public_access
    can :manage, :welcome
    can :show, Referral

    can :read, Comment
    can :read, Hashtag
    can :read, Level
    can :read, Post
    can :read, Topic
    can :read, User
  end

  def authenticated_access(user)
    can :manage, :account
    can :manage, :feed
    can :manage, :inbox
    can :manage, :report
    can :manage, :search
    can :manage, :follower

    can :manage, BookmarkFolder, user: user
    can :manage, Bookmark, user: user
    can :manage, Comment, author: user
    can :manage, Device, user: user
    can :manage, Follow, user: user
    can :manage, Notification, user: user
    can :manage, Post, author: user
    can :manage, Rating, user: user
    can :manage, Referral, inviter: user
    can :manage, Subscription, user: user
    can :manage, Ticket, user: user
  end
end
