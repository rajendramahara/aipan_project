class MembershipPolicy < ApplicationPolicy
  attr_reader :user, :membership

  def initialize(user, membership)
    @user = user
    @membership = membership
  end

  def index?
    user.has_permission?("profile.view_own") || user.has_permission?("salary.view_own") || user.has_permission?("payment.view_own") || user.has_permission?("profile.view_all") || user.has_permission?("salary.view_all") || user.has_permission?("payment.view_all")
  end

  def show?
    index?
  end

  def new?
    user.has_permission?("profile.create")
  end

  def create?
    new?
  end

  def edit?
    # user.has_permission?("profile.edit_all")
    edit_profile?
  end

  def update?
    edit?
  end

  def destroy?
    if user.id == membership&.user_id
      false
    else
      new?
    end
  end

  def view_table?
    if user.id == membership&.user_id
      user.has_permission?("profile.view_own") || user.has_permission?("salary.view_own") || user.has_permission?("payment.view_own")
    else
      user.has_permission?("profile.view_all") || user.has_permission?("salary.view_all") || user.has_permission?("payment.view_all")
    end
  end

  def view_profile?
    if user.id == membership&.user_id
      user.has_permission?("profile.view_own")
    else
      user.has_permission?("profile.view_all")
    end
  end

  def edit_profile?
    if user.id == membership&.user_id
      user.has_permission?("profile.edit_own")
    else
      user.has_permission?("profile.edit_all")
    end
  end

  def view_salary?
    if user.id == membership&.user_id
      user.has_permission?("salary.view_own")
    else
      user.has_permission?("salary.view_all")
    end
  end

  def edit_salary?
    if user.id == membership&.user_id
      user.has_permission?("salary.edit_own")
    else
      user.has_permission?("salary.edit_all")
    end
  end

  def view_payment?
    if user.id == membership&.user_id
      user.has_permission?("payment.view_own")
    else
      user.has_permission?("payment.view_all")
    end
  end

  def edit_payment?
    if user.id == membership&.user_id
      user.has_permission?("payment.edit_own")
    else
      user.has_permission?("payment.edit_all")
    end
  end

  class Scope < ApplicationPolicy::Scope
  end
end
