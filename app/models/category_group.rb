class CategoryGroup < ApplicationRecord
  has_many :categories, dependent: :destroy
end
