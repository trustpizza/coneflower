class Development < ApplicationRecord
    has_one_attached :before_image#, required: true
    has_one_attached :after_image#, required: true
    has_one_attached :logo

    has_many :reviews, dependent: :destroy

    def images
        images = [ before_image, after_image]
    end

    def review_average
        return 0 if reviews.empty?
    
        total_score_sum = reviews.sum(&:score_average)
        average_score = total_score_sum / reviews.size
        average_score.round(2)
      end
    def current_image
      if after_image.attached?
          after_image
      elsif before_image.attached?
          before_image
      else
          nil
      end
    end
end
