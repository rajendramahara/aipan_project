class Organizations::RolesController < Organizations::BaseController
  def index
    @roles = @organization.roles
  end

  def show
  end

  def new
    @role = Role.new
    @permissions = Permission.all
  end

  def create
    @role = Role.new(role_params)
    if @role.save
      if params[:role][:permission_ids].present?
        params[:role][:permission_ids].each do |permission_id|
          RolePermission.create!(role: @role, permission_id: permission_id)
        end
      end

      redirect_to organization_roles_path(@organization), notice: "Role created successfully!"
    else
      @permissions = Permission.all
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @role = Role.find(params[:id])
    @permissions = Permission.all
  end

  def update
    @role = Role.find(params[:id])
    if @role.update(role_params)
      @role.role_permissions.destroy_all
      if params[:role][:permission_ids].present?
        params[:role][:permission_ids].each do |permission_id|
          RolePermission.create!(role: @role, permission_id: permission_id)
        end
      end

      redirect_to organization_roles_path(@organization), notice: "Role updated successfully!"
    else
      @permissions = Permission.all
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def role_params
    params.require(:role).permit(:name).merge(organization_id: @organization.id)
  end
end
