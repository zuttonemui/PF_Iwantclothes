class CreateWantAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :want_answers do |t|
      t.integer :user_id,       null:false
      t.integer :want_cloth_id, null:false
      t.text :content,          null:false
      t.string :url

      t.timestamps
    end
  end
end
