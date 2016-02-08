class UserMailer < ApplicationMailer
  default :from => '"Thierry from Better Days" <holler@betterdaysapp.com>'

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
  
  def activation_reminder(user)
    @user = user
    mail to: user.email, subject: "Activate Your Account To Get Started!"
  end
  
  def daily_reminder(user)
    @user = user
    mail to: user.email, from: '"Thierry from Better Days" <deardiary@reply.betterdaysapp.com>', subject: "Friendly Reminder: Write Journal"
  end
  
end
