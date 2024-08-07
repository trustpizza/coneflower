# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Development.destroy_all
User.destroy_all
ScoreType.destroy_all

number_of_developments = 20
number_of_users = 14
range_of_reviews = (3..14)
number_of_score_types = 5
number_of_scores = 3

addresses = []
CSV.foreach('db/new_england_addresses.csv', headers: true) do |row|
  addresses << row.to_h
end

number_of_score_types.times do
    ScoreType.create!(
        name: Faker::Lorem.unique.word,
        description: Faker::Lorem.sentence(word_count: 10)
    )
end

addresses.each do |address_data|
  # Create the development
  development = Development.create!(
    name: Faker::Company.name,
    acreage: Faker::Number.decimal_part(digits: 2),  # Example for acreage
    description: Faker::Lorem.paragraphs(number: 5).join(". "),
    website: Faker::Internet.url,
    planned_start_date: Faker::Date.forward(days: 30),  # Example: 30 days from today
    planned_end_date: Faker::Date.forward(days: 90),  # Example: 90 days from today
    ecosystem: Faker::Company.industry
  )
  # Get an actual street location
  # Create the address and associate it with the development
  address = Address.create!(
    street_address: address_data["street_address"],
    city: address_data["city"],
    state: address_data["state"],
    postal_code: address_data["postal_code"],
    country: address_data["country"],
    addressable: development
  )

  # Attach images
  logo_url = Faker::LoremFlickr.image(size: "400x400", search_terms: ["logo", "company"])
  logo_io = URI.open(logo_url)
  development.logo.attach(io: logo_io, filename: File.basename(logo_url))

  before_img_url = Faker::LoremFlickr.image(size: "800x1200", search_terms: ['housing', 'development'])
  before_img_io = URI.open(before_img_url)
  development.before_image.attach(io: before_img_io, filename: File.basename(before_img_url))

  after_image_url = Faker::LoremFlickr.image(size: "800x1200", search_terms: ["housing", "development"])
  after_image_io = URI.open(after_image_url)
  development.after_image.attach(io: after_image_io, filename: File.basename(after_image_url))
end


number_of_users.times do
    password = Faker::Internet.password(min_length: 8)
    user = User.create!(
        email: Faker::Internet.unique.email,
        password: password,
        password_confirmation: password,
    )
    profile_pic = Faker::LoremFlickr.image(size: "400x400", search_terms: ["person"])
    profile_io = URI.open(profile_pic)
    
    profile = user.create_profile!(  # Correctly create the profile for the user
      username: Faker::Internet.username,
      biography: Faker::Lorem.sentence,  # Changed to `Faker::Lorem.sentence` for biography
    )
    
    profile.profile_picture.attach(io: profile_io, filename: File.basename(profile_pic))
  end

Development.all.each do |development|
    review_count = rand(range_of_reviews)
    user = User.all.sample
    review_count.times do
        review = user.reviews.create!(
            title: Faker::Company.bs,
            description: Faker::Lorem.paragraphs(number: 3).join(". "),
            development: development
            # Add any necessary attributes for reviews
        )

        number_of_scores.times do
            score_type = ScoreType.order("RANDOM()").first
            review.scores.create!(
                value: rand(1..5),
                score_type: score_type
            )
        end
    end
end