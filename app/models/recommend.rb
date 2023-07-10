class Recommend < ApplicationRecord
  belongs_to :user
  belongs_to :genre, optional: true
  has_many :favorites, dependent: :destroy

  has_one_attached :recommend_image

  validates :content, presence: true, length: { maximum: 140 }

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def get_recommend_image(width, height)
    unless recommend_image.attached?
      file_path = Rails.root.join("app/assets/images/no-image.png")
      recommend_image.attach(io: File.open(file_path), filename: "no-image.png", content_type: "image")
    end
    recommend_image.variant(resize_to_limit: [width, height]).processed
  end
end
