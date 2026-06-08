class Message < ApplicationRecord
has_many :notifications, as: :notifiable, dependent: :destroy
  belongs_to :chat_room
  belongs_to :user

  validates :body, presence: true


after_create :detect_mentions

def detect_mentions
  usernames = body.scan(/@(\w+)/).flatten

  usernames.each do |username|

    mentioned_user = User.find_by(name: username)

    next unless mentioned_user

    Notification.create(
      user: mentioned_user,
      actor: user,
      notifiable: self,
      action: "mentioned you in chat"
    )
  end
end


end

