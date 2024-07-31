class Profile < ApplicationRecord
  belongs_to :user

  # If you're using Active Storage for profile picture
  has_one_attached :profile_picture

  validates :username, presence: true, uniqueness: true
  validates :biography, length: { maximum: 500 }
end
