class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :recommend, optional: true
  belongs_to :want_answer, optional: true

  belongs_to :visitor, class_name: "User", foreign_key: "visitor_id"
  belongs_to :visited, class_name: "User", foreign_key: "visited_id"
end
