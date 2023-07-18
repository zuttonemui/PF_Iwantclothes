class RenameWantClothesToWantItems < ActiveRecord::Migration[6.1]
  def change
    rename_table :want_clothes, :want_items
  end
end
