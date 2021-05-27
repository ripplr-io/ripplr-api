class AddNotifiableToNotification < ActiveRecord::Migration[6.1]
  def change
    add_reference :notifications, :notifiable, type: :uuid, polymorphic: true
  end
end
