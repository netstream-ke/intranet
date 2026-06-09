class UserMailer < ApplicationMailer
  def password_changed(user)
    @user = user
    mail(to: @user.email, subject: "Your password has been changed")
  end
end
