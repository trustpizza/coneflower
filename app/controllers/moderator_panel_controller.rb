class ModeratorPanelController < ApplicationController
  before_action :authenticate_user!
  before_action :require_moderator_or_higher

  def index
  end

  private
  
  def require_moderator_or_higher
    unless current_user.moderator? || current_user.admin? || current_user.owner?
      redirect_to root_path, alert: 'You are not authorized to access this page.'
    end
  end
end
