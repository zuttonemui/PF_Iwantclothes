class Room < ApplicationRecord
  has_many :entries, dependent: :destroy
  has_many :letters, dependent: :destroy
  has_many :notifications, dependent: :destroy

  def chat_partner(me)
    entry = entries.where.not(user_id: me.id).first
    entry.user if entry.present?
  end

  def recent_message(room)
    message = room.letters.order(updated_at: :desc).limit(1)
    @message = message[0]
    if message.present?
      @message.message
    else
      "まだメッセージはありません"
    end
  end

  def create_notification_dm(current_user, letter_id)
    @multiple_entry_records = Entry.where(room_id: id).where.not(user_id: current_user.id)
    @single_entry_record = @multiple_entry_records.find_by(room_id: id)
    notification = current_user.active_notifications.build(
      room_id: id,
      letter_id: letter_id,
      visited_id: @single_entry_record.user_id,
      action: 'dm'
    )

    notification.save if notification.valid?
  end
end
