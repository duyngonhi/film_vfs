class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  before_save :downcase_email
  validates :fullname, presence: true, length: {maximum: 50}
  validates :address, presence: true, length: {maximum: 200}
  validates :phone, length: {maximum: 11}

  ARRAY_ROLE = [[I18n.t("role.none"), nil], [I18n.t("role.role_user"),
    I18n.t("role.role_user")], [I18n.t("role.role_admin"), I18n.t("role.role_admin")]]

  has_many :scripts, dependent: :destroy
  has_many :activities

  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: :followed_id, dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :active_likes, class_name: Like.name,
    foreign_key: :like_user_id, dependent: :destroy
  has_many :liking, through: :active_likes, source: :like_film

  def is_admin?
    role == Settings.role.role_admin
  end

  def follow other_user
    following << other_user
  end

  def unfollow other_user
    following.destroy other_user
  end

  def following? other_user
    following.include? other_user
  end

  def like film
    liking << film
  end

  def unlike film
    liking.destroy film
  end

  def liking? film
    liking.include? film
  end

  def is_user? user
    self == user
  end

  private

  def downcase_email
    self.email = email.downcase
  end
end
