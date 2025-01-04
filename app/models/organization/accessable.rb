module Organization::Accessable
  extend ActiveSupport::Concern

  included do
    has_many :memberships, dependent: :destroy
  end

  def has_membership?(user: Current.user)
    memberships.exists?(user: user)
  end

  def is_administrator?(user: Current.user)
    membership_for(user: user).admin?
  end

  def get_role(user: Current.user)
    membership_for(user: user).role
  end

  def membership_for(user: Current.user)
    memberships.find_by(user: user)
  end
end
