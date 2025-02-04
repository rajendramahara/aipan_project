class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  include Authentication
  before_action :require_authentication

  around_action :set_timezone, if: :sign_in?
  helper_method :current_organization, :current_user
  layout "application"

  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def pundit_user
    Current.user
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

  def sign_in?
    Current.user.present?
  end

  def current_user
    Current.user
  end

  def current_organization
    @current_membership&.organization
  end

  def set_timezone
    Time.use_zone(current_user.give_timezone) do
      yield
    end
  end
end
