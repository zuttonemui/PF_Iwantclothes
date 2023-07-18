class RenameWantClothesIdColumnToClothTags < ActiveRecord::Migration[6.1]
  def change
    rename_column :cloth_tags, :want_clothes_id, :want_item_id
  end
end
