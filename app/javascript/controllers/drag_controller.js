import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  start(event) {
    event.dataTransfer.setData("id", event.target.dataset.id)
  }

  over(event) {
    event.preventDefault()
  }

  drop(event) {
    event.preventDefault()

    const draggedId = event.dataTransfer.getData("id")
    const target = event.target.closest("[data-id]")

    if (!target) return

    fetch(`/news/${draggedId}/move`, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("[name=csrf-token]").content
      },
      body: JSON.stringify({ position: target.dataset.id })
    })
  }
}