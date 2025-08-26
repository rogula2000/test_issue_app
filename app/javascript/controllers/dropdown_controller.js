import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]
  static values = { open: { type: Boolean, default: false } }

  connect() {
    this.update()
    this.boundClickOutside = this.handleClickOutside.bind(this)
    document.addEventListener("click", this.boundClickOutside)
  }

  disconnect() {
    document.removeEventListener("click", this.boundClickOutside)
  }

  toggle(event) {
    event.preventDefault()
    event.stopPropagation()
    this.openValue = !this.openValue
    this.update()
  }

  handleClickOutside(event) {
    if (!this.element.contains(event.target)) {
      if (this.openValue) {
        this.openValue = false
        this.update()
      }
    }
  }

  update() {
    if (this.hasMenuTarget) {
      this.menuTarget.classList.toggle("hidden", !this.openValue)
    }
  }
}


