class User < ApplicationRecord
  MINIMUM_PASSWORD_LENGTH = 8
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_one :profile, dependent: :destroy

  has_many :memberships, dependent: :destroy
  has_many :organizations, through: :memberships

  has_many :department_employees, dependent: :destroy
  has_many :departments, through: :department_employees

  has_many :announcements, dependent: :destroy
  has_many :announcement_recipients, as: :announceable, dependent: :destroy

  validates :password, length: { minimum: MINIMUM_PASSWORD_LENGTH }, if: :password_digest_changed?
  validates :email, presence: true, uniqueness: true

  normalizes :email, with: ->(email) { email.strip.downcase }

  generates_token_for :password_reset, expires_in: 1.hour do
    password_salt.last(10)
  end

  has_many :roles, dependent: :destroy
  has_many :user_roles, dependent: :destroy

  def current_membership
    memberships.find_by(organization: Organization.current)
  end

  def user_role
    user_roles.find_by(organization: Organization.current)&.role
  end

  def has_permission?(module_id)
    user_role&.permissions&.exists?(module_id: module_id)
  end

  def give_timezone
    if profile&.timezone.present?
      return profile&.timezone&.split("/")[1]
    else
      return "Kolkata"
    end
  end
end
