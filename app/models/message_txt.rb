class MessageTxt < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates :body, presence: true

after_create :detect_mentions

def detect_mentions
  usernames = body.scan(/@(\w+)/).flatten

  usernames.each do |username|
    user = User.find_by(name: username)

    next unless user

    Notification.create(
      user: user,
      message: "#{self.user.name} mentioned you in chat"
    )
  end
end
end