class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :want_clothes, dependent: :destroy
  has_many :want_answers, dependent: :destroy
  has_many :recommends, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :entries, dependent: :destroy
  has_many :rooms, through: :entries
  has_many :letters, dependent: :destroy

  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed

  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 10 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join("app/assets/images/no-image.png")
      profile_image.attach(io: File.open(file_path), filename: "no-image.png", content_type: "image")
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def follow(user)
    relationships.create(followed_id: user.id)
  end

  def unfollow(user)
    relationships.find_by(followed_id: user.id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  def mutual_followings
    followings && followers
  end

  def self.search_for(content)
    User.where('name LIKE ?', '%' + content + '%')
  end

  def self.guest
    find_or_create_by!(name: "guestuser", email: "guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end
end