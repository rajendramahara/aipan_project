class Organizations::AnnouncementsController < Organizations::BaseController
  before_action :set_announcement, only: %i[edit show update destroy]
  before_action :set_department_users, only: %i[new edit]

  def index
    @announcements = @organization.announcements
  end

  def show
  end

  def new
    @announcement = Announcement.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_announcement
    @announcement = Announcement.find(params[:id])
  end

  def set_department_users
    @departments = @organization.departments
    @users = @organization.users
  end
end
