class Notice < ApplicationRecord
  belongs_to :user

  has_one_attached :document

  validates :title, presence: true
  validates :document, presence: true
end
