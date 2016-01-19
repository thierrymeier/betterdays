class UserMailer < ApplicationMailer
  default :from => 'holler@betterdaysapp.com'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account activation"
  end
  
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password reset"
  end
  
  def reminder(user)
    @user = user
    mail to: user.email, subject: "You didn't journal in three days – need help?"
  end
  
  def test_email(user)
    @user = user
    mail to: user.email, subject: "Test email yo"
  end
  
end
