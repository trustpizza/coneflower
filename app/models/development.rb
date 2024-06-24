class Development < ApplicationRecord
    has_one_attached :before_image#, required: true
    has_one_attached :after_image#, required: true
    has_one_attached :logo

    has_many :reviews, dependent: :destroy

    def images
        images = [ before_image, after_image]
    end

    def review_average
        scores = reviews.joins(:scores).pluck('scores.value')
        return 0 if scores.empty?
        (scores.sum.to_f / scores.size).round(2)
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
