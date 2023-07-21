class RenameGenreIdToCategoryIdInWantItem < ActiveRecord::Migration[6.1]

  def up
    rename_column :want_items, :genre_id, :category_id
  end

  def down
    rename_column :want_items, :category_id, :genre_id
  end
end
