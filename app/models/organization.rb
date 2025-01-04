class Organization < ApplicationRecord
  include Attachable, Accessable

  has_one_attached :logo, dependent: :purge_later

  has_many :users, through: :memberships
  has_many :projects, dependent: :destroy
  has_many :departments, dependent: :destroy
  has_many :announcements, dependent: :destroy
  has_many :announcement_recipients, as: :announceable, dependent: :destroy

  validates :name, presence: true

  broadcasts_to ->(organization) { "organizations_#{Current.user.id}" }
end
