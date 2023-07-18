class WantItem < ApplicationRecord
  belongs_to :user
  belongs_to :genre, optional: true
  belongs_to :category, optional: true
  has_many :want_answers, dependent: :destroy
  has_many :cloth_tags, dependent: :destroy
  has_many :tags, through: :cloth_tags

  has_one_attached :want_image

  validates :content, presence: true, length: { maximum: 200 }

  def get_want_image(width, height)
    want_image.variant(resize_to_limit: [width, height]).processed
  end

  def save_notification_answer!(current_user, answer_id, visited_id)
    notification = current_user.active_notifications.new(
      recommend_id: nil,
      answer_id: answer_id,
      visited_id: visited_id,
      action: 'answer'
    )

    if notification.visitor_id == notification.visited_id
      notification.is_checked = true
    end
    notification.save if notification.valid?
  end

  def save_tags(sent_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      self.tags.delete Tag.find_by(name: old)
    end

    new_tags.each do |new|
      cloth_tag = Tag.find_or_create_by(name: new)
      self.tags << cloth_tag
    end
  end

  def self.search_for(content)
    WantItem.where('content LIKE ?', '%' + content + '%')
  end
end
