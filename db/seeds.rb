User.find_or_create_by!(email: "admin@intranet.com") do |user|
  user.name = "Admin"
  user.password = "Kar_elin@12034"
  user.password_confirmation = "Kar_elin@12034"
  user.role = "admin"
  user.verified = true
  user.suspended = false
  user.force_password_change = false
end
