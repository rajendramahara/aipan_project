class MembershipInvitation
  include ActiveModel::Model

  attr_accessor :email, :organization, :role

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role, presence: true

  validates :role, inclusion: { in: Membership.roles.keys }

  def save
    return false unless valid?

    user = User.find_by(email: email) || invite_user
    return false unless user.present?

    add_user_to_organization(user)
  end

  private

  def invite_user
    user = User.create(email: email, password: "password")
    token = user.generate_token_for(:password_reset)

    InvitationMailer.with(user: user, invitation_token: token).send_invitation.deliver_now

    return user
  end

  def add_user_to_organization(user)
    if organization.has_membership?(user: user)
      errors.add(:base, "#{email} is already a member of that organization!")
      return false
    else
      organization.memberships.create(user: user, role: role)
    end
  end
end
