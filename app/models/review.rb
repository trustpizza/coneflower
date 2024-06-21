class Review < ApplicationRecord
  has_many :scores

  belongs_to :user
  belongs_to :development
end
