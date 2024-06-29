class Moderator::SearchController < ApplicationController
  def index
    @query = params[:query]
    


    @search_type = params[:search_type]
    @results = []

    if @query.present? && @search_type.present?
      # if @query.length < 3
      if false # not currently working
        flash.now[:notice] = "NO!"
        redirect_back(fallback_location: moderator_index_path, alert: "No")
      else
        case @search_type
        when "users"
          @pagy, @results = pagy(
            User.where("LOWER(username) LIKE ?", "%#{@query.downcase}%"),
            items: 3
          )
        else
          @pagy, @results = pagy(
            Development.where(
              "LOWER(name) LIKE ? OR LOWER(description) LIKE ?", "%#{@query.downcase}%", "%#{@query.downcase}%"
            ),
            items: 3
          )
        end
      end
    end
  end

  private

  def search_params
    params.require(:search).permit(:query, :search_type)
  end

end
