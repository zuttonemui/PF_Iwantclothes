class CreateCategoryGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :category_groups do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
