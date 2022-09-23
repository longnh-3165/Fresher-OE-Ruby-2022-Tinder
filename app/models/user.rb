class User < ApplicationRecord
  include MatchPagesHelper
  attr_accessor :remember_token

  belongs_to :country, optional: true
  enum type_of: {basic: 0, gold: 1}
  enum gender: {male: 0, female: 1}
  has_many :messages, dependent: :destroy, foreign_key: :user_send_id
  has_many :active_relationships, class_name: Relationship.name,
                                  foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
                                  foreign_key: :followed_id, dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships

  delegate :name, to: :country, prefix: true, allow_nil: true

  ALLOWED_USER_PARAMS = %i(name email password
                           password_confirmation date_of_birth
                           gender country_id phone facebook
                           description).freeze

  before_save{email.downcase!}
  validates :name, presence: true
  validates :email, presence: true,
                    format: {with: Settings.regex.email}, uniqueness: true
  validates :password, presence: true, length: {minimum: Settings.pw.min}
  validates :gender, presence: true
  validates :date_of_birth, presence: true
  validates :phone,
            format: {with: Settings.regex.phone}
  validates :description, length: {maximum: Settings.des.max}

  has_secure_password

  scope :by_gender,
        ->(gender){where(gender: gender.presence || Settings.gender.range)}

  scope :by_age,
        ->(max_age,
           min_age){where(date_of_birth: get_filter_range(min_age, max_age))}

  scope :by_place,
        ->(place){where(country_id: place.presence || Settings.place.range)}

  scope :by_name_like,
        ->(name){where "name LIKE ?", "%#{name}%"}

  scope :by_type_of,
        ->(type_of){where(type_of: type_of.presence || Settings.type_of.range)}

  scope :by_actived,
        ->(actived){where(actived: actived.presence || Settings.actived.range)}

  scope :by_admin,
        ->(admin){where(admin: admin.presence || Settings.admin.range)}

  scope :exclude_id, ->(id){where.not(id: id)}

  scope :exclude_followed, ->(id){where.not(followed: id)}

  CREATE_ATTRS = %i(name actived admin type).freeze

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

  def like_each_other? other_user, current_user
    return unless following.include?(other_user) &&
                  followers.include?(other_user)

    ids = [other_user.id, current_user.id]
    relationship = Relationship.by_follower(ids).by_followed(ids)
    relationship.update_all(status: true)
  end

  def unfollow other_user
    following.delete(other_user)
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
