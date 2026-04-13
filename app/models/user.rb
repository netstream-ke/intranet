class User < ApplicationRecord
has_secure_password


validates :password,
  length: { minimum: 8 },
  format: {
    with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+\z/,
    message: "must include at least one lowercase, uppercase letter, and number"
  },
  if: -> { password.present? }


has_many :tasks, dependent: :destroy
has_many :comments, dependent: :destroy
has_many :notifications, dependent: :destroy

  enum :role, {
    employee: 0,
    manager: 1,
    admin: 2
  }

  after_initialize :set_default_role, if: :new_record?
private
  def set_default_role
    self.role ||= :employee
  end

after_initialize do
  self.suspended = false if self.suspended.nil?
end

after_initialize do
  self.force_password_change = false if self.force_password_change.nil?
end

validates :email, presence: true, uniqueness: true
end

  