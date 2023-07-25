class AddRoomIdToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :room_id, :integer
    add_column :notifications, :letter_id, :integer
  end
end
