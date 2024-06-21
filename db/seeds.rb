# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Development.delete_all

number_of_developments = 7

number_of_developments.times do
    development = Development.create!(
        name: Faker::Company.name,
        address: Faker::Address.full_address,
        acreage: Faker::Number.decimal_part(digits: 2),  # Example for acreage
        description: Faker::Lorem.paragraph,
        website: Faker::Internet.url,
        planned_start_date: Faker::Date.forward(days: 30),  # Example: 30 days from today
        planned_end_date: Faker::Date.forward(days: 90)  # Example: 90 days from today
    )
end