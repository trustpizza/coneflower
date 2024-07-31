class Review < ApplicationRecord
  has_many :scores, dependent: :destroy
  accepts_nested_attributes_for :scores, allow_destroy: true

  belongs_to :user
  belongs_to :development

  # Validations
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :user_id, :development_id, presence: true

  # Custom method to calculate average score
  def score_average
    scores = self.scores.pluck(:value)
    return 0 if scores.empty?
    (scores.sum.to_f / scores.count).round(2)
  end
end
