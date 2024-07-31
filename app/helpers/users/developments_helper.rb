module Users::DevelopmentsHelper
  def current_location
    {
      latitude: session[:latitude],
      longitude: session[:longitude]
    }
  end
end
