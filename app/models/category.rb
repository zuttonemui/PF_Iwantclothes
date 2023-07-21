class Category < ApplicationRecord
  belongs_to :category_group
  has_many :want_items
  has_many :reommends
end
