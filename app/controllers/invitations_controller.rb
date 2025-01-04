class InvitationsController < AuthController
  def accepts
  end

  def update
    user = User.find_by_token_for(:password_reset, params[:invitation_token])

    if user.nil?
      flash.now[:notice] = "Invalid token!"
      render :accepts, status: :unprocessable_entity
    elsif user.update(invitation_params)
      flash.now[:notice] = "password reset successfully!"
      sign_in(user)
      redirect_to dashboard_path
    end
  end

  private

  def invitation_params
    params.require(:password_reset).permit(:password, :invitation_token)
  end
end
