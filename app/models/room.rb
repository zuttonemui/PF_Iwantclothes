class Room < ApplicationRecord
  has_many :entrys, dependent: :destroy
  has_many :letters, dependent: :destroy
end
