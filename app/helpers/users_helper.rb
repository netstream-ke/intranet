module UsersHelper

def online_status(user)
    return false unless user.last_seen_at
    user.last_seen_at > 2.minutes.ago
  end
end
