class RenameWantClothesIdColumnToWantAnswers < ActiveRecord::Migration[6.1]
  def change
    rename_column :want_answers, :want_clothes_id, :want_item_id
  end
end
