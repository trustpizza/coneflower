class Moderator::DevelopmentsController < ModeratorController
  def index
    @pagy, @developments = pagy(Development.all, items: 3)
    @development_averages = @developments.map { |development| [development.id, development.review_average] }.to_h
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
