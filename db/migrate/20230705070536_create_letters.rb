class CreateLetters < ActiveRecord::Migration[6.1]
  def change
    create_table :letters do |t|
      t.integer :user_id,   null:false
      t.integer :room_id,   null:false
      t.string :message,    null:false

      t.timestamps
    end
  end
end
