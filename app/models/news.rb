class News < ApplicationRecord
  has_many_attached :media
  has_rich_text :content
  belongs_to :user

  # CALLBACKS (CLEANED)
  before_create :auto_route_story
  after_create :handle_hero_promotion

  # ENUMS
  enum :story_type, {
    main: 0,
    secondary: 1,
    gallery: 2
  }

  enum :category, {
    top_news: 0,
    entertainment: 1,
    sports: 2,
    csr: 3,
    games: 4
  }

enum :placement, {
  left: 0,
  center: 1,
  right: 2,
  grid: 3
}

  # ORDERING
  default_scope { order(Arel.sql("COALESCE(position, 9999) ASC")) }

  # VALIDATIONS
  validates :title, :writer, :content, presence: true

  # =========================
  # HERO PROMOTION (SINGLE SOURCE OF TRUTH)
  # =========================
  def handle_hero_promotion
    return unless main?

    # Demote existing hero
    News.where(story_type: :main)
        .where.not(id: self.id)
        .update_all(
          story_type: News.story_types[:secondary],
          placement: News.placements[:center]
        )

    # Ensure this one is correct
    update_columns(
      placement: News.placements[:center]
    )
  end

def reading_time
  return 0 unless content.present?

  words = content.to_plain_text.split.size
  (words / 200.0).ceil
end

  # =========================
  # AUTO ROUTING
  # =========================
  def auto_route_story
    case story_type
    when "main"
      self.placement = :center

    when "secondary"
      route_secondary

    when "gallery"
      self.placement = :grid
    end
  end

  private

  def route_secondary
    if News.where(placement: :left).count == 0
      self.placement = :left

    elsif News.where(placement: :center).count < 3
      self.placement = :center

    elsif News.where(placement: :right).count < 4
      self.placement = :right

    else
      self.placement = :grid
    end
  end
end