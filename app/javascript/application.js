// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "./controllers"
import "./channels"
import "trix"
import "@rails/actiontext"
function toggleDropdown() {
  const dropdown = document.getElementById("dropdown");
  dropdown.classList.toggle("hidden");
}

// Optional: close when clicking outside
document.addEventListener("click", function (e) {
  const menu = document.querySelector(".user-menu");
  const dropdown = document.getElementById("dropdown");

  if (menu && !menu.contains(e.target)) {
    dropdown.classList.add("hidden");
  }
});


document.addEventListener("turbo:load", () => {
  const columns = document.querySelectorAll(".column");

  columns.forEach(col => {
    new Sortable(col, {
      group: "shared",
      animation: 150,

      onEnd: () => {
        saveOrder();
      }
    });
  });

  function saveOrder() {
    let order = [];

    document.querySelectorAll(".column").forEach(col => {
      const placement = col.dataset.placement;

      col.querySelectorAll(".draggable").forEach((el, index) => {
        order.push({
          id: el.dataset.id,
          placement: placement,
          position: index
        });
      });
    });

    fetch("/news/sort", {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content
      },
      body: JSON.stringify({ order: order })
    });
  }
});

tinymce.init({
  selector: '.tinymce',
  menubar: true,
  plugins: 'lists link image table code',
  toolbar:
    'undo redo | bold italic underline | bullist numlist | link image | code'
});

import consumer from "./consumer"

document.addEventListener("turbo:load", () => {
  const chatRoomId = document.getElementById("chat-room").dataset.id

  consumer.subscriptions.create(
    { channel: "ChatRoomChannel", chat_room_id: chatRoomId },
    {
      received(data) {
        const messages = document.getElementById("messages")

        messages.insertAdjacentHTML("beforeend", `
          <div class="message">
            <strong>${data.user}</strong>: ${data.body}
          </div>
        `)
      }
    }
  )
})


