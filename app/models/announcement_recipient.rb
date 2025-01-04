class AnnouncementRecipient < ApplicationRecord
  belongs_to :announceable, polymorphic: true
  belongs_to :announcement
end
