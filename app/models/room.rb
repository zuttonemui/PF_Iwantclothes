class Room < ApplicationRecord
  has_many :entries, dependent: :destroy
  has_many :letters, dependent: :destroy
end
