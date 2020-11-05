# frozen_string_literal: true

class CreateDoorkeeperTables < ActiveRecord::Migration[6.0]
  def change
    create_table :oauth_access_tokens, id: :uuid do |t|
      t.belongs_to :resource_owner, index: true, foreign_key: { to_table: :users }, type: :uuid
      t.uuid     :application_id
      t.string   :token, null: false
      t.string   :refresh_token
      t.integer  :expires_in
      t.datetime :revoked_at
      t.datetime :created_at, null: false
      t.string   :scopes
    end

    add_index :oauth_access_tokens, :token, unique: true
    add_index :oauth_access_tokens, :refresh_token, unique: true
  end
end
