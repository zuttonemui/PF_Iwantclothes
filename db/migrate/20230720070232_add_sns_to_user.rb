class AddSnsToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :instagram, :string
    add_column :users, :twitter, :string
  end
end
