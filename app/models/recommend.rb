class Recommend < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy

  has_one_attached :recommend_image

  validates :content, presence: true, length: { maximum: 140 }

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def create_notification_fav!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and recommend_id = ? and action = ? ", current_user.id, user_id, id, 'fav'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        recommend_id: id,
        visited_id: user_id,
        action: 'fav'
      )
      notification.save if notification.valid?
    end
  end

  def get_recommend_image(width, height)
    unless recommend_image.attached?
      file_path = Rails.root.join("app/assets/images/no-image.png")
      recommend_image.attach(io: File.open(file_path), filename: "no-image.png", content_type: "image")
    end
    recommend_image.variant(resize_to_limit: [width, height]).processed
  end

  def self.search_for(content)
    Recommend.where('content LIKE ?', '%' + content + '%')
  end
end
