class Notification < ApplicationRecord
  belongs_to :user_send, class_name: User.name
  belongs_to :user_receive, class_name: User.name
  scope :newest, ->{order(created_at: :desc)}
end
