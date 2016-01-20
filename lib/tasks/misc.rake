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

namespace :misc do
  desc "Find out who hasn't written in three days"
  task :nopost3days => :environment do
    User.all.each do |user|
      if user.reminder_count == 3
        puts "#{user.id}: #{user.first_name} <#{user.email}>"
      end
    end
  end
end