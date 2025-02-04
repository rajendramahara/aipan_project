class Organization < ApplicationRecord
  include Attachable, Accessable

  has_one_attached :logo, dependent: :purge_later

  has_many :users, through: :memberships
  has_many :projects, dependent: :destroy
  has_many :departments, dependent: :destroy
  has_many :announcements, dependent: :destroy
  has_many :announcement_recipients, as: :announceable, dependent: :destroy
  has_many :user_roles, dependent: :destroy
  has_many :roles, dependent: :destroy

  validates :name, presence: true

  # broadcasts_to ->(organization) { "organizations_#{Current.user.id}" }

  def self.current
    Thread.current[:current_organization]
  end

  def self.current=(organization)
    Thread.current[:current_organization] = organization
  end
end
