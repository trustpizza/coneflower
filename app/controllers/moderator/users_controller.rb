class Moderator::UsersController < ApplicationController
  include ModeratorAuthentication

  before_action :require_admin_or_higher
  before_action :set_user, only: %i[ show ban unban ]

  def index
    @pagy, @users = pagy(User.all, items: 10)
  end

  def show
  end

  def ban
    @user.update(banned: true)
    respond_to do |format|
      format.html { redirect_to moderator_user_path(@user), notice: 'User was successfully banned.' }
      format.turbo_stream { redirect_to moderator_user_path(@user), notice: "User was successfully banned." }
      format.json { head :no_content }
    end
  end

  def unban
    @user.update(banned: false)
    respond_to do |format|
      format.html { redirect_to moderator_user_path(@user), notice: 'User was successfully unbanned.' }
      format.turbo_stream { redirect_to moderator_user_path(@user), notice: "User was successfully unbanned." }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username)
  end
end
