class Announcement < ApplicationRecord
  belongs_to :creator, class_name: "User"
  belongs_to :organization

  has_many :announcement_recipients, dependent: :destroy

  # validates :title, :content, :saverity, presence :true
  enum :severity, %w[ low high ].index_by(&:itself), default: :high
end
