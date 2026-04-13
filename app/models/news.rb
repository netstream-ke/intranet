class News < ApplicationRecord
 has_many_attached :images

  enum :category, {
    top_news: "top_news",
    entertainment: "entertainment",
    sports: "sports",
    csr: "csr",
    games: "games"
  }

  scope :main_story, -> { where(is_main: true).order(created_at: :desc).first }
  scope :others, -> { where(is_main: [false, nil]).order(created_at: :desc) }


  validates :title, :category, :writer, :content, presence: true
end
  