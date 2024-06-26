class Review < ApplicationRecord
  has_many :scores, dependent: :destroy

  accepts_nested_attributes_for :scores, allow_destroy: true


  belongs_to :user
  belongs_to :development

  # Validations
  validates :title, :description, presence: true

  def score_average
    scores = self.scores.pluck(:value)
    return 0 if scores.empty?
    (scores.sum.to_f / scores.count).round(2)
  end
end
