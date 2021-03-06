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

  def is_admin?
    role == Settings.role.role_admin
  end

  private

  def downcase_email
    self.email = email.downcase
  end
end
