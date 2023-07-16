class CreateClothTags < ActiveRecord::Migration[6.1]
  def change
    create_table :cloth_tags do |t|
      t.references :tag, null: false, foreign_key: true
      t.references :want_clothes, null: false, foreign_key: true

      t.timestamps
    end
  end
end
