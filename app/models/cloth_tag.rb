class ClothTag < ApplicationRecord
  belongs_to :want_item
  belongs_to :tag
end
