import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="geolocation"
export default class extends Controller {
  connect() {
    const url = new URL(window.location.href);
    const hasGeolocationParams = url.searchParams.has('latitude') && url.searchParams.has('longitude');

    if (!hasGeolocationParams) {
      this.getUserLocation();
    }
  }

  getUserLocation() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(
        this.success.bind(this),
        this.error.bind(this)
      );
    } else {
      alert("Geolocation is not supported by this browser.");
    }
  }

  success(position) {
    const lat = position.coords.latitude;
    const lon = position.coords.longitude;
    const distance = 25; // Example distance

    // Construct the URL with query parameters
    const url = new URL(window.location.href);
    url.searchParams.set('latitude', lat);
    url.searchParams.set('longitude', lon);
    url.searchParams.set('distance', distance);

    // Redirect to the URL
    window.location.href = url.toString();
  }

  error() {
    alert("Unable to retrieve your location.");
  }
}