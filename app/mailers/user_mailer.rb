class UserMailer < ApplicationMailer
  default :from => '"Thierry from Better Days" <holler@betterdaysapp.com>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account Activation"
  end
  
  def start_email(user)
    @user = user
    mail to: user.email, subject: "A few tips to get started"
  end
  
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password reset"
  end
  
  def test_email(user)
    @user = user
    mail to: user.email, subject: "Email test"
  end
  
end
