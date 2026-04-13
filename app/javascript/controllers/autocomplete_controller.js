import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results"]

  connect() {
    this.index = -1
  }

  search(event) {
    const value = this.inputTarget.value
    const match = value.match(/(@\w*|#\w*)$/)

    if (!match) {
      this.resultsTarget.innerHTML = ""
      return
    }

    const query = match[0]
    const type = query.startsWith("@") ? "users" : "tasks"

    fetch(`/${type}/autocomplete?q=${query.substring(1)}`)
      .then(res => res.json())
      .then(data => this.renderResults(data, type))
  }

  renderResults(data, type) {
    this.resultsTarget.innerHTML = ""

    data.forEach(item => {
      const el = document.createElement("div")
      el.classList.add("autocomplete-item")
      el.innerText = type === "users" ? `@${item.name}` : `#${item.title}`

      el.addEventListener("click", () => {
        this.select(item, type)
      })

      this.resultsTarget.appendChild(el)
    })
  }

  select(item, type) {
    let value = this.inputTarget.value

    value = value.replace(/(@\w*|#\w*)$/, "")

    if (type === "users") {
      this.inputTarget.value = value + "@" + item.name + " "
    } else {
      this.inputTarget.value = value + "#" + item.title + " "
    }

    this.resultsTarget.innerHTML = ""
  }
}