class ChangeUserRoomsToEntrys < ActiveRecord::Migration[6.1]
  def change
    rename_table :user_rooms, :entrys
  end
end
