class CreateWantClothes < ActiveRecord::Migration[6.1]
  def change
    create_table :want_clothes do |t|
      t.integer :user_id,   null: false
      t.integer :genre_id
      t.text :content,      null: false
      t.integer :budget
      t.boolean :is_answer, null: false, dafault: true

      t.timestamps
    end
  end
end
