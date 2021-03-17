# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_17_110532) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.uuid "record_id", null: false
    t.uuid "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "billings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.string "status"
    t.string "product"
    t.string "stripe_customer_id"
    t.datetime "end_at"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deleted_at"], name: "index_billings_on_deleted_at"
    t.index ["user_id"], name: "index_billings_on_user_id"
  end

  create_table "bookmark_folders", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "bookmark_folder_id"
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "bookmarks_count", default: 0, null: false
    t.integer "bookmark_folders_count", default: 0, null: false
    t.index ["bookmark_folder_id", "user_id", "name"], name: "ux_bookmark_folders_bookmark_folder_user_name", unique: true
    t.index ["bookmark_folder_id"], name: "index_bookmark_folders_on_bookmark_folder_id"
    t.index ["user_id"], name: "index_bookmark_folders_on_user_id"
  end

  create_table "bookmarks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "bookmark_folder_id"
    t.uuid "post_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "user_id"
    t.index ["bookmark_folder_id"], name: "index_bookmarks_on_bookmark_folder_id"
    t.index ["post_id"], name: "index_bookmarks_on_post_id"
    t.index ["user_id", "post_id"], name: "index_bookmarks_on_user_id_and_post_id", unique: true
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "channel_devices", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "onesignal_id", null: false
  end

  create_table "channel_emails", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
  end

  create_table "channels", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.string "channelable_type"
    t.uuid "channelable_id"
    t.string "name", null: false
    t.json "settings", default: {}, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["channelable_type", "channelable_id"], name: "index_channels_on_channelable"
    t.index ["user_id", "name"], name: "index_channels_on_user_id_and_name", unique: true
    t.index ["user_id"], name: "index_channels_on_user_id"
  end

  create_table "comments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "body", null: false
    t.uuid "post_id"
    t.uuid "comment_id"
    t.uuid "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.integer "ratings_points_total", default: 0, null: false
    t.integer "replies_count", default: 0, null: false
    t.index ["author_id"], name: "index_comments_on_author_id"
    t.index ["comment_id"], name: "index_comments_on_comment_id"
    t.index ["deleted_at"], name: "index_comments_on_deleted_at"
    t.index ["post_id"], name: "index_comments_on_post_id"
  end

  create_table "communities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "owner_id"
    t.string "name", limit: 20, null: false
    t.string "slug", limit: 255, null: false
    t.text "description", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "posts_count", default: 0, null: false
    t.integer "followers_count", default: 0, null: false
    t.index ["owner_id"], name: "index_communities_on_owner_id"
    t.index ["slug"], name: "index_communities_on_slug", unique: true
  end

  create_table "community_posts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "community_id"
    t.uuid "post_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["community_id", "post_id"], name: "index_community_posts_on_community_id_and_post_id", unique: true
    t.index ["community_id"], name: "index_community_posts_on_community_id"
    t.index ["post_id"], name: "index_community_posts_on_post_id"
  end

  create_table "community_topics", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "community_id"
    t.uuid "topic_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["community_id", "topic_id"], name: "index_community_topics_on_community_id_and_topic_id", unique: true
    t.index ["community_id"], name: "index_community_topics_on_community_id"
    t.index ["topic_id"], name: "index_community_topics_on_topic_id"
  end

  create_table "content_sources", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "topic_id"
    t.string "feed_url", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "community_id"
    t.index ["community_id"], name: "index_content_sources_on_community_id"
    t.index ["topic_id"], name: "index_content_sources_on_topic_id"
    t.index ["user_id"], name: "index_content_sources_on_user_id"
  end

  create_table "follows", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "followable_type"
    t.uuid "followable_id"
    t.uuid "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["followable_type", "followable_id"], name: "index_follows_on_followable_type_and_followable_id"
    t.index ["user_id", "followable_id", "followable_type"], name: "index_follows_on_user_id_and_followable_id_and_followable_type", unique: true
    t.index ["user_id"], name: "index_follows_on_user_id"
  end

  create_table "hashtags", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "posts_count", default: 0, null: false
    t.integer "followers_count", default: 0, null: false
    t.index ["name"], name: "index_hashtags_on_name", unique: true
  end

  create_table "inbox_channels", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "inbox_id"
    t.uuid "channel_id"
    t.json "settings"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["channel_id"], name: "index_inbox_channels_on_channel_id"
    t.index ["inbox_id", "channel_id"], name: "index_inbox_channels_on_inbox_id_and_channel_id", unique: true
    t.index ["inbox_id"], name: "index_inbox_channels_on_inbox_id"
    t.index ["user_id"], name: "index_inbox_channels_on_user_id"
  end

  create_table "inbox_items", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "inbox_id"
    t.string "inboxable_type"
    t.uuid "inboxable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "archived_at"
    t.index ["inbox_id", "inboxable_id", "inboxable_type"], name: "ux_inbox_items_inbox_inboxable", unique: true
    t.index ["inbox_id"], name: "index_inbox_items_on_inbox_id"
    t.index ["inboxable_type", "inboxable_id"], name: "index_inbox_items_on_inboxable_type_and_inboxable_id"
  end

  create_table "inbox_notifications", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "inbox_item_id"
    t.uuid "inbox_channel_id"
    t.datetime "scheduled_to"
    t.datetime "delivered_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["inbox_channel_id"], name: "index_inbox_notifications_on_inbox_channel_id"
    t.index ["inbox_item_id", "inbox_channel_id"], name: "index_inbox_notifications_on_inbox_item_id_and_inbox_channel_id", unique: true
    t.index ["inbox_item_id"], name: "index_inbox_notifications_on_inbox_item_id"
  end

  create_table "inboxes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.string "name", null: false
    t.json "settings", default: {}, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "description"
    t.integer "inbox_items_count", default: 0, null: false
    t.integer "inbox_items_archived_count", default: 0, null: false
    t.integer "subscription_inboxes_count", default: 0, null: false
    t.index ["user_id", "name"], name: "index_inboxes_on_user_id_and_name", unique: true
    t.index ["user_id"], name: "index_inboxes_on_user_id"
  end

  create_table "levels", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.integer "from", null: false
    t.integer "to", null: false
    t.integer "posts", null: false
    t.integer "referrals", null: false
    t.integer "subscriptions", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "inboxes", null: false
  end

  create_table "notifications", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.string "type"
    t.json "data", null: false
    t.datetime "read_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "oauth_access_tokens", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "resource_owner_id"
    t.uuid "application_id"
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "post_hashtags", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "post_id"
    t.uuid "hashtag_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_post_hashtags_on_deleted_at"
    t.index ["hashtag_id"], name: "index_post_hashtags_on_hashtag_id"
    t.index ["post_id", "hashtag_id"], name: "index_post_hashtags_on_post_id_and_hashtag_id", unique: true
    t.index ["post_id"], name: "index_post_hashtags_on_post_id"
  end

  create_table "posts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title", null: false
    t.string "url", null: false
    t.string "body", null: false
    t.uuid "topic_id"
    t.uuid "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.integer "ratings_points_total", default: 0, null: false
    t.integer "comments_count", default: 0, null: false
    t.integer "trending_score", default: 0, null: false
    t.index ["author_id"], name: "index_posts_on_author_id"
    t.index ["deleted_at"], name: "index_posts_on_deleted_at"
    t.index ["topic_id"], name: "index_posts_on_topic_id"
    t.index ["trending_score"], name: "index_posts_on_trending_score"
  end

  create_table "prizes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.string "prizable_type"
    t.uuid "prizable_id"
    t.integer "points", null: false
    t.string "name", null: false
    t.datetime "given_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["prizable_type", "prizable_id"], name: "index_prizes_on_prizable_type_and_prizable_id"
    t.index ["user_id"], name: "index_prizes_on_user_id"
  end

  create_table "ratings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "points", default: 0, null: false
    t.string "ratable_type"
    t.uuid "ratable_id"
    t.uuid "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_ratings_on_deleted_at"
    t.index ["ratable_type", "ratable_id"], name: "index_ratings_on_ratable_type_and_ratable_id"
    t.index ["user_id", "ratable_id", "ratable_type"], name: "index_ratings_on_user_id_and_ratable_id_and_ratable_type", unique: true
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "referrals", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "inviter_id"
    t.uuid "invitee_id"
    t.string "name", null: false
    t.string "email", null: false
    t.datetime "accepted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["invitee_id"], name: "index_referrals_on_invitee_id"
    t.index ["inviter_id", "email"], name: "index_referrals_on_inviter_id_and_email", unique: true
    t.index ["inviter_id", "invitee_id"], name: "index_referrals_on_inviter_id_and_invitee_id", unique: true, where: "(invitee_id IS NOT NULL)"
    t.index ["inviter_id"], name: "index_referrals_on_inviter_id"
  end

  create_table "subscription_inboxes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "subscription_id"
    t.uuid "inbox_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["inbox_id"], name: "index_subscription_inboxes_on_inbox_id"
    t.index ["subscription_id"], name: "index_subscription_inboxes_on_subscription_id"
  end

  create_table "subscriptions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.string "subscribable_type"
    t.uuid "subscribable_id"
    t.json "settings", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["subscribable_type", "subscribable_id"], name: "index_subscriptions_on_subscribable_type_and_subscribable_id"
    t.index ["user_id", "subscribable_id", "subscribable_type"], name: "ux_subscriptions_user_subscribable", unique: true
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "tickets", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.string "title", null: false
    t.text "body", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_tickets_on_user_id"
  end

  create_table "topics", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "avatar", null: false
    t.string "slug", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "posts_count", default: 0, null: false
    t.integer "followers_count", default: 0, null: false
    t.index ["slug"], name: "index_topics_on_slug", unique: true
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name", null: false
    t.text "bio"
    t.string "slug", null: false
    t.string "timezone", default: "UTC", null: false
    t.string "country"
    t.datetime "onboarded_at"
    t.boolean "supporter", default: false, null: false
    t.uuid "level_id"
    t.datetime "deleted_at"
    t.integer "posts_count", default: 0, null: false
    t.integer "followers_count", default: 0, null: false
    t.integer "following_users_count", default: 0, null: false
    t.integer "following_topics_count", default: 0, null: false
    t.integer "following_hashtags_count", default: 0, null: false
    t.boolean "subscribed_to_marketing", default: false, null: false
    t.datetime "onboarding_started_at"
    t.datetime "onboarding_finished_at"
    t.integer "following_communities_count", default: 0, null: false
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["level_id"], name: "index_users_on_level_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_users_on_slug", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comments", "users", column: "author_id"
  add_foreign_key "communities", "users", column: "owner_id"
  add_foreign_key "oauth_access_tokens", "users", column: "resource_owner_id"
  add_foreign_key "posts", "users", column: "author_id"
  add_foreign_key "referrals", "users", column: "invitee_id"
  add_foreign_key "referrals", "users", column: "inviter_id"
end
