class User < ApplicationRecord
  include MatchPagesHelper
  attr_accessor :remember_token

  belongs_to :country, optional: true
  enum type_of: {basic: 0, gold: 1}
  has_many :messages, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name,
                                  foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
                                  foreign_key: :followed_id, dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships
  has_secure_password

  scope :by_gender,
        ->(gender){where(gender: gender.presence || Settings.gender.range)}

  scope :by_age,
        ->(max_age,
           min_age){where(date_of_birth: get_filter_range(min_age, max_age))}

  scope :by_place,
        ->(place){where(countries_id: place.presence || Settings.place.range)}

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def like other_user
    following << other_user
  end

  def like? other_user
    following.include? other_user.id
  end

  def remember
    self.remember_token = User.new_token
    update_column :remember_digest, User.digest(remember_token)
  end

  def forget
    update_column :remember_digest, nil
  end

  def authenticated? remember_token
    return false unless remember_token

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
end
