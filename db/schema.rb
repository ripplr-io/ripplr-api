# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_06_152659) do

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
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "bookmark_folders", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "bookmark_folder_id"
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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

  create_table "comments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "body", null: false
    t.uuid "post_id"
    t.uuid "comment_id"
    t.uuid "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_id"], name: "index_comments_on_author_id"
    t.index ["comment_id"], name: "index_comments_on_comment_id"
    t.index ["post_id"], name: "index_comments_on_post_id"
  end

  create_table "devices", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.string "name", null: false
    t.string "device_type", null: false
    t.string "onesignal_id", null: false
    t.json "settings", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "name"], name: "index_devices_on_user_id_and_name", unique: true
    t.index ["user_id"], name: "index_devices_on_user_id"
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
    t.index ["name"], name: "index_hashtags_on_name", unique: true
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
  end

  create_table "notifications", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.string "type", null: false
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
    t.index ["hashtag_id"], name: "index_post_hashtags_on_hashtag_id"
    t.index ["post_id", "hashtag_id"], name: "index_post_hashtags_on_post_id_and_hashtag_id", unique: true
    t.index ["post_id"], name: "index_post_hashtags_on_post_id"
  end

  create_table "posts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title", null: false
    t.string "url", null: false
    t.string "body", null: false
    t.string "image", null: false
    t.uuid "topic_id"
    t.uuid "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_id"], name: "index_posts_on_author_id"
    t.index ["topic_id"], name: "index_posts_on_topic_id"
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

  create_table "push_notifications", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "device_id"
    t.uuid "subscription_id"
    t.uuid "post_id"
    t.string "title", null: false
    t.text "body", null: false
    t.string "thumbnail", null: false
    t.datetime "scheduled_to"
    t.datetime "delivered_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["device_id"], name: "index_push_notifications_on_device_id"
    t.index ["post_id", "device_id"], name: "index_push_notifications_on_post_id_and_device_id", unique: true
    t.index ["post_id"], name: "index_push_notifications_on_post_id"
    t.index ["subscription_id"], name: "index_push_notifications_on_subscription_id"
  end

  create_table "ratings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "points", default: 0, null: false
    t.string "ratable_type"
    t.uuid "ratable_id"
    t.uuid "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.string "avatar"
    t.string "slug", null: false
    t.string "timezone", default: "UTC", null: false
    t.string "country"
    t.datetime "onboarded_at"
    t.boolean "supporter", default: false, null: false
    t.uuid "level_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["level_id"], name: "index_users_on_level_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_users_on_slug", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comments", "users", column: "author_id"
  add_foreign_key "oauth_access_tokens", "users", column: "resource_owner_id"
  add_foreign_key "posts", "users", column: "author_id"
  add_foreign_key "referrals", "users", column: "invitee_id"
  add_foreign_key "referrals", "users", column: "inviter_id"
end
