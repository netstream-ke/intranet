import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  toggle(event) {
    const content = event.currentTarget.nextElementSibling
    content.classList.toggle("hidden")
  }
}