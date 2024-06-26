class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: %i[ new edit update destroy create ]
  before_action :set_development
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  # GET /developments/:development_id/reviews
  def index
    # Pagination!!!
    page = params[:page].to_i
    page = [page, 1].max
    @per_page = 3
    total_pages = (@development.reviews.count.to_f / @per_page).ceil
  
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
  
    @reviews = @development.reviews.limit(@per_page).offset(offset)
    @score_averages = @reviews.map { |review| [review.id, review.score_average] }.to_h
  end
  
  # GET /developments/:development_id/reviews/:id
  def show
    @score_average = @review.score_average
  end

  # GET /developments/:development_id/reviews/new
  def new
    @review = @development.reviews.build
    ScoreType.all.each do |score_type|
      @review.scores.build(score_type: score_type)
    end
  end

  # GET /developments/:development_id/reviews/:id/edit
  def edit
  end

  # POST /developments/:development_id/reviews
  def create
    @review = @development.reviews.build(review_params)
    @review.user = current_user

    respond_to do |format|
      if @review.save
        format.html { redirect_to development_review_url(@development, @review), notice: "Review was successfully created." }
        format.json { render :show, status: :created, location: development_review_url(@development, @review) }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /developments/:development_id/reviews/:id
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to development_review_url(@development, @review), notice: "Review was successfully updated." }
        format.json { render :show, status: :ok, location: development_review_url(@development, @review) }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /developments/:development_id/reviews/:id
  def destroy
    @review.destroy

    respond_to do |format|
      format.html { redirect_to development_reviews_url(@development), notice: "Review was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_development
    @development = Development.find(params[:development_id])
  end

  def set_review
    @review = @development.reviews.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:title, :description, scores_attributes: [:id, :value, :score_type_id, :_destroy])
  end
end
