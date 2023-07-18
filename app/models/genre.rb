class Genre < ApplicationRecord
  has_many :want_items
  has_many :recommends
end
