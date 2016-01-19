namespace :mail do
  desc "Send test email to myself"
  
  task :mailme => :environment do
    user = User.find(1)
    UserMailer.test_email(user).deliver_now
  end
  
end