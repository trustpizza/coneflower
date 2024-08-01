class Users::SearchController < ApplicationController
  def index
    @query = params[:query]
    @address = {
      street_address: params[:street_address],
      city: params[:city],
      state: params[:state],
      postal_code: params[:postal_code],
      country: params[:country]
    }

    if @query.present?
      # Combine address fields into a single address string
      @address_parts = [
        @address[:street_address],
        @address[:city],
        @address[:state],
        @address[:postal_code],
        @address[:country]
      ].compact.join(', ')

      # Search for Developments
      @pagy, @results = pagy(
        Development.where(
          "LOWER(name) LIKE ? OR LOWER(description) LIKE ?", "%#{@query.downcase}%", "%#{@query.downcase}%"
        ),
        items: 3
      )

      # If an address is provided, filter by proximity
      if address_parts.present?
        geocoded_address = Geocoder.search(address_parts).first
        if geocoded_address
          lat, lon = geocoded_address.latitude, geocoded_address.longitude
          distance = params[:radius] || 50
          @pagy, @results = pagy(
            Development.within_distance_of(lat, lon, distance.to_i),
            items: 3
          )
        end
      end

      if !@results.present?
        redirect_to search_index_path, notice: "The following search returned zero results."
      end
    end
  end
end
