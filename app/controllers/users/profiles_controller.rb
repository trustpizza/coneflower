class Users::ProfilesController < ApplicationController
  before_action :authenticate_user!, except: %i[ show ]

  def new
    if current_user.profile
      redirect_to edit_profile_path(current_user.profile)
    else
      @profile = Profile.new
    end
  end

  def create
    @profile = current_user.build_profile(profile_params)
    if @profile.save
      redirect_to profile_path(@profile), notice: 'Profile was successfully created.'
    else
      render :new
    end
  end

  def edit
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile
    if @profile.update(profile_params)
      redirect_to profile_path(@profile), notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  def show
    @profile = Profile.find(params[:id])
  end

  private

  def profile_params
    params.require(:profile).permit(:username, :biography, :profile_picture)
  end
end
