class Development < ApplicationRecord
    has_one_attached :before_image
    has_one_attached :after_image
    has_one_attached :logo
  
    # Address
    has_one :address, as: :addressable, dependent: :destroy
    accepts_nested_attributes_for :address
  
    # Reviews
    has_many :reviews, dependent: :destroy
  
    # Validations
    validate :attached_images
    validate :logo_format
    validate :image_size
  
    def images
      [before_image, after_image]
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
  
    private
  
    def attached_images
      if before_image.attached? == false || after_image.attached? == false
        errors.add(:base, "Both before_image and after_image must be attached")
      end
    end
  
    def logo_format
      if logo.attached?
        unless logo.blob.content_type.in?(%w[image/jpeg image/png])
          errors.add(:logo, "must be a JPEG or PNG")
        end
      end
    end
  
    def image_size
      if before_image.attached? && before_image.blob.byte_size > 5.megabytes
        errors.add(:before_image, "should be less than 5MB")
      end
  
      if after_image.attached? && after_image.blob.byte_size > 5.megabytes
        errors.add(:after_image, "should be less than 5MB")
      end
  
      if logo.attached? && logo.blob.byte_size > 2.megabytes
        errors.add(:logo, "should be less than 2MB")
      end
    end
end
  