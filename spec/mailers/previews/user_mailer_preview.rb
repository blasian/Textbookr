# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/password_reset
  def password_reset
    user = UserAccount.first
    user.password_reset_token = UserAccount.new_token
    UserMailer.password_reset(user)
  end

  def notify_user
    UserMailer.notify_user(UserAccount.first, Search.first, Book.first)
  end

  def account_activation
    user = UserAccount.first
    user.activation_token = UserAccount.new_token
    UserMailer.account_activation(user)
  end

end
