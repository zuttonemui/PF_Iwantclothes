class Room < ApplicationRecord
  has_many :entries, dependent: :destroy
  has_many :letters, dependent: :destroy
  
  def chat_partner(me)
    entry = entries.where.not(user_id: me.id).first
    entry.user if entry.present?
  end
end
