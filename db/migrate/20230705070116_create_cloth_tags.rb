class CreateClothTags < ActiveRecord::Migration[6.1]
  def change
    create_table :cloth_tags do |t|
      t.integer :target_id,   null:false
      t.integer :tag_id,      null:false

      t.timestamps
    end
  end
end
