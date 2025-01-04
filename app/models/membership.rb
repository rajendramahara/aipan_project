class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :organization

  enum :role, %w[ member admin ].index_by(&:itself), default: :member
end
