class WantAnswer < ApplicationRecord
  belongs_to :user
  belongs_to :want_item
  has_many :notifications, dependent: :destroy

  has_one_attached :answer_image

  validates :content, presence: true, length: { maximum: 300 }

  def get_want_image(width, height)
    want_image.variant(resize_to_limit: [width, height]).processed
  end
end
