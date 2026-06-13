import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.addEventListener("keydown", (e) => {
      if (e.key === "Enter" && !e.shiftKey) {
        e.preventDefault()
        this.element.closest("form").requestSubmit()
      }
    })
  }
}

connect() {
  this.element.addEventListener("input", () => {
    this.element.style.height = "auto"
    this.element.style.height = this.element.scrollHeight + "px"
  })
}
  connect() {
  const emojis = ["😀","😂","🔥","👍","🎉","😎"]

  document.querySelector(".emoji-btn")?.addEventListener("click", () => {
    const emoji = emojis[Math.floor(Math.random() * emojis.length)]
    this.element.value += emoji
    this.element.focus()
  })
}
