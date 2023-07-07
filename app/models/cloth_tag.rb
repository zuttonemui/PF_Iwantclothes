class ClothTag < ApplicationRecord
  belongs_to :user
  belongs_to :want_clothes
  belongs_to :recommend
  belongs_to :tag
end
