class Moderator::DevelopmentsController < ModeratorController
  before_action :set_development, only: %i[ edit update show ]

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
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_development
    @development = Development.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def development_params
    params.require(:development).permit(:name, :address, :acreage, :description, :website, :planned_start_date, :planned_end_date, :before_image, :after_image)
  end
end
