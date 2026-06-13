import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  toggle(event) {
    const content = this.element.querySelector(".brief-content")
    content.classList.toggle("hidden")
  }
}