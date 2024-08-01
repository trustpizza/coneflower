class Users::DevelopmentsController < ApplicationController
  before_action :set_development, only: %i[ show render_description ]

  # GET /developments or /developments.json
  def index
    items = 3

    lat = params[:latitude]
    lon = params[:longitude]
    distance = params[:distance] || 25  # Default to 50 miles if not provided
    if lat.present? && lon.present?
      @pagy, @developments = pagy(Development.within_distance_of(lat.to_f, lon.to_f, distance.to_i), items: items)
    else
      @pagy, @developments = pagy(Development.none, items: items)
    end
    @development_averages = @developments.map { |development| [development.id, development.review_average] }.to_h
  end

  # GET /developments/1 or /developments/1.json
  def show
    @image = @development.current_image
    @average = @development.review_average
  end


  def render_description
    render partial: "custom_description", locals: { development: @development }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_development
      @development = Development.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def development_params
      params.require(:development).permit(:name, :address, :acreage, :description, :website, :planned_start_date, :planned_end_date, :before_image, :after_image, :latitude, :longitude, :distance)
    end
end

