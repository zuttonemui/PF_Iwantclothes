class RenameGenreIdToCategoryIdInRecommend < ActiveRecord::Migration[6.1]
  def up
    rename_column :recommends, :genre_id, :category_id
  end

  def down
    rename_column :recommends, :category_id, :genre_id
  end
end
