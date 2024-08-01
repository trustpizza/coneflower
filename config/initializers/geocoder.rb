Geocoder.configure(
  lookup: :google,
  api_key: ENV['GOOGLE_MAPS_API_KEY'],  # Make sure your API key is stored in an environment variable
  timeout: 5,  # Timeout in seconds
  units: :mi   # Use miles for distance measurement
)
