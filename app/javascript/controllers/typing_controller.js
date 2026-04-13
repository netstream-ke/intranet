import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  connect() {
    this.timeout = null
  }

  typing() {
    clearTimeout(this.timeout)

    fetch(`/typing?task_id=${this.data.get("taskId")}`, {
      method: "POST"
    })

    this.timeout = setTimeout(() => {
      fetch(`/stop_typing?task_id=${this.data.get("taskId")}`, {
        method: "POST"
      })
    }, 2000)
  }
}