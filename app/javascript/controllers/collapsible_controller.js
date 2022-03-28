import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["togglers", "collapsible", "openButton", "closeButton"];
  static values = { expanded: Boolean };

  connect() {
    this.togglersTarget.classList.remove('hidden');
    this.render();
  }

  render() {
    if (this.expandedValue) {
      this.collapsibleTarget.classList.remove('hidden');
      this.openButtonTarget.classList.add('hidden');
      this.closeButtonTarget.classList.remove('hidden');
    } else {
      this.collapsibleTarget.classList.add('hidden');
      this.openButtonTarget.classList.remove('hidden');
      this.closeButtonTarget.classList.add('hidden');
    }
  }

  close() {
    this.expandedValue = false;
    this.render();
  }

  open() {
    this.expandedValue = true;
    this.render();
  }
}
