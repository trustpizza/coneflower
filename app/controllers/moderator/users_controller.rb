class Moderator::UsersController < ApplicationController
  include ModeratorAuthentication

  before_action :require_admin_or_higher
  before_action :set_user, only: %i[ show toggle_ban ]

  def index
    @pagy, @users = pagy(User.where('role < ?', User.roles[current_user.role]), items: 10)
  end

  def show
  end

  def toggle_ban
    if @user == current_user || current_user.role_before_type_cast < @user.role_before_type_cast
      respond_to do |format|
        format.html { redirect_to moderator_user_path(@user), alert: 'You do not have permission to perform this action.' }
        format.turbo_stream { redirect_to moderator_user_path(@user), alert: 'You do not have permission to perform this action.' }
        format.json { render json: { error: 'You do not have permission to perform this action.' }, status: :forbidden }
      end
    else
      @user.update(banned: !@user.banned)
      respond_to do |format|
        format.html { redirect_to moderator_user_path(@user), notice: 'User ban status was successfully updated.' }
        format.turbo_stream { redirect_to moderator_user_path(@user), notice: 'User ban status was successfully updated.' }
        format.json { head :no_content }
      end
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
