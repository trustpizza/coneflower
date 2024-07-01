class ModeratorController < ApplicationController
  include ModeratorAuthentication
  layout "moderator"

  def index
    redirect_to moderator_developments_path
  end
  
end