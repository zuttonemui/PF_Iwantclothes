class CreateRecommends < ActiveRecord::Migration[6.1]
  def change
    create_table :recommends do |t|
      t.integer :user_id,   null:false
      t.integer :genre_id,  null:false
      t.string :content,    null:false
      t.string :url

      t.timestamps
    end
  end
end
