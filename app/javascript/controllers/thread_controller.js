import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  toggle(event) {
    event.preventDefault()

    const id = event.currentTarget.dataset.commentId
    const thread = document.getElementById(`thread-${id}`)

    thread.classList.toggle("hidden")
  }
}