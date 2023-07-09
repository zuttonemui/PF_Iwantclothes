class Genre < ApplicationRecord
  has_many :want_clothes
  has_many :recommends
end
