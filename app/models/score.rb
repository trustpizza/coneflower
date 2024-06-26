class Score < ApplicationRecord
  belongs_to :review
  belongs_to :score_type

  validates :value, inclusion: { in: 1..5 }
end
