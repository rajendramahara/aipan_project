class Organizations::MembershipsController < Organizations::BaseController
  def index
    authorize Membership
    @memberships = @organization.users
  end

  def show
    authorize Membership
    @membership = @organization.memberships.find_by(user_id: params[:id])
  end

  def new
    authorize Membership
  end

  def create
    authorize Membership
    @membership = MembershipInvitation.new(email: params[:email], role: "admin", organization: @organization)

    if @membership.save
      user = User.find_by(email: params[:email])
      UserRole.create!(user_id: user.id, role_id: params[:role_id], organization: @organization)
      redirect_to organization_memberships_path(@organization), notice: "Invitation send successfully!"
    else
      flash.now[:alert] = "Fail to send Invitation!"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @membership = @organization.memberships.find_by(user_id: params[:id])
    authorize @membership
  end

  def update
    @membership = @organization.memberships.find_by(id: params[:id])
    authorize @membership

    role_id = params[:membership][:role_id]
    user_role = UserRole.find_or_initialize_by(user_id: @membership.user_id, organization: @organization)
    user_role.role_id = role_id
    if user_role.save
      redirect_to organization_memberships_path(@organization), notice: "Role update successfully!"
    else
      flash[:alert] = "Fail to update role!"
      redirect_to organization_memberships_path(@organization)
    end
  end

  def destroy
    @membership = @organization.memberships.find_by(user_id: params[:id])
    @membership.destroy
    redirect_to organization_memberships_path(@organization), notice: "Employee Destroy successfully!"
  end
end
