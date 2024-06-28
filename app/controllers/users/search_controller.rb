class Users::SearchController < ApplicationController
    def index
      @query = params[:query]
      @results = []

      if @query.present?
        # Search for Developments
        developments = Development.where(
          "LOWER(name) LIKE ? OR LOWER(description) LIKE ?", "%#{@query.downcase}%", "%#{@query.downcase}%"
        )
        # Search for Users
        # users = User.where("LOWER(username) LIKE ?", "%#{@query.downcase}%")

        end
        @pagy, @results = pagy(
          Development.where(
            "LOWER(name) LIKE ? OR LOWER(description) LIKE ?", "%#{@query.downcase}%", "%#{@query.downcase}%"
          ),
          items: 3
        )
    end
end
