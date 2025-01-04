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

  def give_timezone
    if profile&.timezone.present?
      return profile&.timezone&.split("/")[1]
    else
      return "Kolkata"
    end
  end
end
