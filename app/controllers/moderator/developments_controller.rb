class Moderator::DevelopmentsController < ModeratorController
  before_action :set_development, only: %i[ edit update show destroy toggle_published ]
  before_action :require_admin_or_higher, only: %i[ destroy ]

  def index
    @pagy, @developments = pagy(Development.all, items: 3)
    @development_averages = @developments.map { |development| [development.id, development.review_average] }.to_h
  end

  def show
    @image = @development.current_image
    @average = @development.review_average
  end

  def edit
  end 

  def update
    if @development.update(development_params)
      redirect_to moderator_development_path(@development), notice: 'Development was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @development.destroy
    respond_to do |format|
      format.html
      format.turbo_stream
    end
    redirect_to moderator_developments_path
  end

  def toggle_published
    @development.update(published: !@development.published)
    respond_to do |format|
      format.html { redirect_to moderator_development_url(@development), notice: 'Development status was successfully updated.' }
      format.turbo_stream { redirect_to moderator_development_url(@development), notice: "Development status successfully updated." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_development
    @development = Development.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def development_params
    params.require(:development).permit(:name, :address, :acreage, :description, :website, :planned_start_date, :planned_end_date, :before_image, :after_image, :latitude, :longitude, address_attributes: [:id, :street_address, :city, :state, :postal_code, :country])
  end
end
