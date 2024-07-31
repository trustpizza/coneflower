class Profile < ApplicationRecord
  belongs_to :user

  # If you're using Active Storage for profile picture
  has_one_attached :profile_picture

  # Validations
  validates :username, presence: true, uniqueness: true
  validates :biography, length: { maximum: 240 }

  # Optional: You can add a validation for the attached profile picture if needed
  validate :acceptable_profile_picture

  private

  def acceptable_profile_picture
    return unless profile_picture.attached?

    unless profile_picture.blob.byte_size <= 1.megabyte
      errors.add(:profile_picture, "is too big (should be less than 1MB)")
    end

    acceptable_types = ["image/jpeg", "image/png"]
    unless acceptable_types.include?(profile_picture.blob.content_type)
      errors.add(:profile_picture, "must be a JPEG or PNG")
    end
  end
end
