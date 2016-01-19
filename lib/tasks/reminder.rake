namespace :mail do
  desc "Send test email to myself"
  
  task :mailme => :environment do
    UserMailer.test_email(1).deliver_now
  end
  
end