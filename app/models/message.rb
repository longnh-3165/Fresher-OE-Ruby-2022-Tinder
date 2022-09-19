class Message < ApplicationRecord
  belongs_to :user, foreign_key: :user_send_id
  scope :newest, ->{order(:created_at).last(3)}
  scope :get_messages, (lambda do |sender_id, receiver_id|
    where(user_receive_id: sender_id, user_send_id: receiver_id)
      .or(where(user_receive_id: receiver_id, user_send_id: sender_id))
  end)

  delegate :name, to: :user, prefix: true, allow_nil: true
end
