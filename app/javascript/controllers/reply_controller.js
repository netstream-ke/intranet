import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  toggle(event) {
    event.preventDefault()

    const id = event.currentTarget.dataset.commentId
    const form = document.getElementById(`reply-form-${id}`)

    form.classList.toggle("hidden")
  }
}