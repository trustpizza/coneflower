class Review < ApplicationRecord
  has_many :scores, dependent: :destroy

  belongs_to :user
  belongs_to :development
end
