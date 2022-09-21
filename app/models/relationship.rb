class Relationship < ApplicationRecord
  belongs_to :follower, class_name: User.name
  belongs_to :followed, class_name: User.name

  scope :by_follower, ->(ids){where(follower: ids)}

  scope :by_followed, ->(ids){where(followed: ids)}

  scope :relationship_users, ->{where(status: true)}
end
