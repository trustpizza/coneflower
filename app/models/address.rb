class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  # Validations
  validates :street_address, :city, :state, :postal_code, :country, presence: true
  validates :postal_code, format: { with: /\A\d{5}(-\d{4})?\z/, message: "should be in the format 12345 or 12345-6789" }
end
