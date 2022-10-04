class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  include MatchPagesHelper

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
  validates :gender, presence: true
  validates :date_of_birth, presence: true
  validates :phone,
            format: {with: Settings.regex.phone}
  validates :description, length: {maximum: Settings.des.max}

  scope :by_gender,
        ->(gender){where(gender: gender.presence || Settings.gender.range)}

  scope :by_age,
        ->(max_age,
           min_age){where(date_of_birth: get_filter_range(min_age, max_age))}

  scope :by_place,
        ->(place){where(country_id: place.presence || Settings.place.range)}

  scope :exclude_id, ->(id){where.not(id: id)}

  scope :exclude_followed, ->(id){where.not(followed: id)}

  ransack_alias :name_email_create_at, :name_or_email_or_created_at

  ransacker :created_at do
    Arel.sql("date(created_at)")
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
end
