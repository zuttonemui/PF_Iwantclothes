class Tag < ApplicationRecord
  has_many :cloth_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :users, through: :cloth_tags
  has_many :want_clothes, through: :cloth_tags
  has_many :recommends, through: :cloth_tags
end
