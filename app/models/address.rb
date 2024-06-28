class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true
  validates :street_address, :city, :state, :postal_code, :country, presence: true
end
