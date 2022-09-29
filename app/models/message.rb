class Message < ApplicationRecord
  belongs_to :user, foreign_key: :user_send_id

  scope :newest, ->{order created_at: :desc}

  scope :by_user_receive, ->(ids){where user_receive_id: ids}

  scope :by_user_send, ->(ids){where user_send_id: ids}

  delegate :name, to: :user, prefix: true, allow_nil: true

  CREATE_ATTRS = %i(content user_receive_id).freeze
end
