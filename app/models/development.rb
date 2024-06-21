class Development < ApplicationRecord
    has_one_attached :before_image#, required: true
    has_one_attached :after_image#, required: true
    has_one_attached :logo

    has_many :reviews

    def review_average
        scores = reviews.joins(:scores).pluck('scores.value')
        return 0 if scores.empty?
        scores.sum.to_f / scores.size
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
