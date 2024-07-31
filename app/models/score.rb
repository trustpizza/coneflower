class Score < ApplicationRecord
  belongs_to :review
  belongs_to :score_type

  # Validations
  validates :value, presence: true, inclusion: { in: 1..5 }
  validates :review_id, :score_type_id, presence: true
end
