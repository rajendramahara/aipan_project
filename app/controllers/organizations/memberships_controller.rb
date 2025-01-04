class Organizations::MembershipsController < Organizations::BaseController
  def index
    @memberships = @organization.users
  end

  def new
  end

  def create
    @membership = MembershipInvitation.new(email: params[:email], role: params[:role], organization: @organization)

    if @membership.save
      redirect_to organization_memberships_path(@organization), notice: "Invitation send successfully!"
    else
      flash.now[:alert] = "Fail to send Invitation!"
      render :new, status: :unprocessable_entity
    end
  end
end
