import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  toggleForm(event) {
    const id = event.currentTarget.dataset.taskId
    const form = document.getElementById(`comments-${id}`)
    if (form) form.classList.toggle("hidden")
  }

  toggleReplies(event) {
    const id = event.currentTarget.dataset.taskId
    const replies = document.getElementById(`replies-${id}`)
    if (replies) replies.classList.toggle("hidden")
  }
}