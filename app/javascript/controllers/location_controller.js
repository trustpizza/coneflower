import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="location"
export default class extends Controller {
  static targets = [];

  connect() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(this.saveLocation.bind(this), this.handleError.bind(this));
    } else {
      console.error('Geolocation is not supported by this browser.');
    }
  }

  saveLocation(position) {
    const { latitude, longitude } = position.coords;

    // Save location data to localStorage
    localStorage.setItem('latitude', latitude);
    localStorage.setItem('longitude', longitude);

    console.log('Location saved to localStorage:', { latitude, longitude });
  }

  handleError(error) {
    console.error('Error getting location:', error);
  }
}
