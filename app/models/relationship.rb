class Relationship < ApplicationRecord
  belongs_to :follower, class_name: User.name
  belongs_to :followed, class_name: User.name

  scope :get_relationship,
        ->(user_id){where(follower: user_id).or(where(followed: user_id))}
  scope :get_followed_users,
        ->(user_id){where(follower: user_id, status: true)}
end
