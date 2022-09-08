class User < ApplicationRecord
  belongs_to :country, optional: true
  enum type_of: {basic: 0, gold: 1}
  has_many :messages, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name,
                                  foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
                                  foreign_key: :followed_id, dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships

  def like other_user
    following << other_user
  end

  def like? other_user
    following.include? other_user
  end
end
