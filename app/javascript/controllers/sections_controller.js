import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["section"]

  toggle(event) {
    event.preventDefault();
    const button = event.currentTarget;
    const targetId = button.dataset.sectionsTarget;
    const targetSection = this.sectionTargets.find(
      section => section.id === targetId
    );  


    this.sectionTargets.forEach(section => {
      if (section == targetSection && targetSection.classList.contains("hidden")) {
        section.classList.remove("hidden"); // Show the targeted section
      } else {
        section.classList.add("hidden"); // Hide all other sections
      }
    });

    
    if (targetSection) {

      if (!targetSection.classList.contains("hidden")) {
        // If the section is already visible, do nothing
        return;
      }
      targetSection.classList.remove("hidden"); // Sh

    }
  };
}
