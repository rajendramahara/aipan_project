class Organizations::BaseController < ApplicationController
  before_action :set_org

  private

  def set_org
    @organization = Organization.find(params[:organization_id])
    @current_membership = current_user.memberships.find_by(organization: @organization)
  end
end
