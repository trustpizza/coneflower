import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["link"]

  connect() {
    // Initialize the active class based on current page or default logic
    this.linkTargets.forEach((link) => {
      link.addEventListener("click", () => {
        this.setActiveLink(link);
      });
    });
  };

  setActiveLink(link) {
    this.linkTargets.forEach((link) => {
      link.classList.remove("underline");
    });
    link.classList.add("underline");
  }
}
