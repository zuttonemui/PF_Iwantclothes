class WantClothes < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :want_answers, dependent: :destroy
  has_many :cloth_tags, dependent: :destroy
  has_many :tags, through: :cloth_tags

  has_one_attached :want_image

  validates :content, presence: true, length: { maximum: 200 }

  def get_want_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join("app/assets/images/no-image.png")
      want_image.attach(io: File.open(file_path), filename: "no-image.png", content_type: "image")
    end
    want_image.variant(resize_to_limit: [width, height]).processed
  end

  def save_tags(sent_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      self.tags.delete Tag.find_by(name: old)
    end

    new_tags.each do |new|
      clothes_tag = Tag.find_or_create_by(name: new)
      self.tags << clothes_tag
    end
  end
end
