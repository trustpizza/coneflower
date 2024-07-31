class LocationsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:set]

  def set
    session[:latitude] = params[:latitude]
    session[:longitude] = params[:longitude]
    render json: { success: true }
  end
end
