class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  # Validations
  validates :street_address, :city, :state, :postal_code, :country, presence: true
  validates :postal_code, format: { with: /\A\d{5}(-\d{4})?\z/, message: "should be in the format 12345 or 12345-6789" }

  # Geocoding
  geocoded_by :full_address
  after_validation :geocode_address, if: :address_changed?

  # Return a full address as a single string
  def full_address
    [street_address, city, state, postal_code, country].compact.join(', ')
  end

  # Optional: Method to return the coordinates in a human-readable format
  def coordinates
    [latitude, longitude].compact.join(', ')
  end

  private

  def geocode_address
    result = Geocoder.search(full_address).first
    if result
      self.latitude = result.latitude
      self.longitude = result.longitude
    else
      Rails.logger.error("Geocoding failed for address: #{full_address}")
      Rails.logger.error("Raw response: #{Geocoder.search(full_address).inspect}")
    end
  rescue Geocoder::Error => e
    Rails.logger.error("Geocoding API error: #{e.message}")
  rescue => e
    Rails.logger.error("Unexpected error: #{e.message}")
  end

  def address_changed?
    street_address_changed? || city_changed? || state_changed? || postal_code_changed? || country_changed?
  end
end
