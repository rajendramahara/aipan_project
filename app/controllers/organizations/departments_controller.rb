class Organizations::DepartmentsController < Organizations::BaseController
  before_action :set_department, only: %i[edit show update destroy update_department_user]

  def index
    @departments = @organization.departments
  end

  def show
    # @organization_employees = User.where.not(id: DepartmentEmployee.pluck(:user_id))
    @organization_employees = User.includes(:memberships).where(memberships: { organization: @organization }).where.not(memberships: { user_id: DepartmentEmployee.joins(:department).where(department: { organization: @organization, id: @department.id }).pluck(:user_id) })
  end

  def new
    @department = Department.new
  end

  def create
    @department = @organization.departments.new(department_params)
    if @department.save
      redirect_to organization_departments_path(@organization), notice: "Department created successfully!"
    else
      flash.now[:alert] = "FAiled to create department"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @department.update(department_params)
      redirect_to organization_departments_path(@organization), notice: "Department updated successfully!"
    else
      flash.now[:alert] = "FAiled to update department"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @department.destroy
      redirect_to organization_departments_path(@organization), notice: "Department deleted successfully!"
    end
  end

  def update_department_user
    user = User.find(params[:user_id])
    if params[:commit].downcase == "add"
      @department.users << user

      redirect_to organization_department_path(@organization, @department), notice: "User added successfully!"
    else
      @department.users.destroy(user)
      redirect_to organization_department_path(@organization, @department), notice: "Remove user from department!"
    end
  end

  private

  def set_department
    @department = Department.find(params[:id])
  end

  def department_params
    params.require(:department).permit(:name)
  end
end
