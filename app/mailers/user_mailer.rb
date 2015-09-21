class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #

  def password_reset(user)
  	@user = user

    mail to: user.email, subject: "Password Reset"
  end

  def notify_user(user, query, book)
  	@user = user
  	@query = query
  	@book = book

  	mail(to: @user.email, subject: 'Your book has been posted')
  end
end
