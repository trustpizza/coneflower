class Score < ApplicationRecord
  belongs_to :review
  belongs_to :score_type
end
