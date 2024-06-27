class AdminPanelController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin_or_higher

  def index
  end
  
  def require_admin_or_higher
    unless current_user.admin? || current_user.owner?
      redirect_to root_path, alert: 'You are not authorized to access this page.'
    end
  end
end
