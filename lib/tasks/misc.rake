namespace :mail do
  desc "Send test email to myself"
  
  task :mailme => :environment do
    user = User.find(1)
    UserMailer.test_email(user).deliver_now
  end
  
end

namespace :misc do
  desc "Set all reminder counts to 0"
  
  task :reminderzero => :environment do
    User.all.each do |user|
      user.update_attribute(:reminder_count, 0)
    end
  end
  
end