class Users::SearchController < ApplicationController
  def index
    @query = params[:query]
    @results = []

    if @query.present?
      # Search for Developments
      @pagy, @results = pagy(
        Development.where(
          "LOWER(name) LIKE ? OR LOWER(description) LIKE ?", "%#{@query.downcase}%", "%#{@query.downcase}%"
        ),
        items: 3
      )
    end 
  end
end
