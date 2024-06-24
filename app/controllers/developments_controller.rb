class DevelopmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_development, only: %i[ show edit update destroy ]

  # GET /developments or /developments.json
  def index
    page = params[:page].to_i
    page = [page, 1].max
    @per_page = 3
    total_pages = (Development.count / @per_page).ceil + 1
    # @page_numbers = (page - 2..page + 2).select { |num| num.positive? && num <= total_pages}
    # Calculate the range for @page_numbers
    nearest_count = 5
    start_number = [page - 2, 1].max
    end_number = [page + 2, total_pages].min

    # Adjust the start and end numbers if necessary
    if (end_number - start_number + 1) < nearest_count
      if page <= 3
        end_number = [start_number + nearest_count - 1, total_pages].min
      elsif page >= total_pages - 2
        start_number = [end_number - nearest_count + 1, 1].max
      else
        start_number = page - 2
        end_number = page + 2
      end
    end

    # Generate @page_numbers array
    @page_numbers = (start_number..end_number).to_a
    offset = (page - 1) * @per_page
    puts(offset)
    @developments = Development.limit(@per_page).offset(offset)
  end

  # GET /developments/1 or /developments/1.json
  def show
    @image = @development.current_image
  end

  # GET /developments/new
  def new
    @development = Development.new
  end

  # GET /developments/1/edit
  def edit
  end

  # POST /developments or /developments.json
  def create
    @development = Development.new(development_params)

    respond_to do |format|
      if @development.save
        format.html { redirect_to development_url(@development), notice: "Development was successfully created." }
        format.json { render :show, status: :created, location: @development }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @development.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /developments/1 or /developments/1.json
  def update
    respond_to do |format|
      if @development.update(development_params)
        format.html { redirect_to development_url(@development), notice: "Development was successfully updated." }
        format.json { render :show, status: :ok, location: @development }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @development.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /developments/1 or /developments/1.json
  def destroy
    @development.destroy!

    respond_to do |format|
      format.html { redirect_to developments_url, notice: "Development was successfully destroyed." }
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
      params.require(:development).permit(:name, :address, :acreage, :description, :website, :planned_start_date, :planned_end_date, :before_image, :after_image)
    end
end
