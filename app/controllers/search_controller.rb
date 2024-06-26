class SearchController < ApplicationController
  def index
    @query = params[:query]
    @results = []
    
    if @query.present?
      # Search for Developments
      developments = Development.where("LOWER(name) LIKE ? OR LOWER(description) LIKE ?", "%#{@query.downcase}%", "%#{@query.downcase}%")
      # Search for Users
      # users = User.where("LOWER(username) LIKE ?", "%#{@query.downcase}%")

      @results.concat(developments)
      # @results.concat(users)
    end

    @results.uniq!  # Remove du
  end
end
