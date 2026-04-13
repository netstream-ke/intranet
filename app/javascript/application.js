// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "./controllers"
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