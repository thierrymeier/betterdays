namespace :mail do
  desc "Send daily reminder to users"
  task :daily_reminder => :environment do
    User.with_reminder.find_each do |user|
      Time.zone = user.time_zone
      
      if Time.current.strftime("%I:00 %p") == user.reminder_time && user.reminded == false
        UserMailer.daily_reminder(user).deliver_now
        user.update_attribute(:reminded, true)
        puts "Send email"
        
      end
    end
  end
end

namespace :mail do
  desc "Send daily reminder to users"
  task :reset_daily_reminder => :environment do
    User.with_reminder.find_each do |user|
      Time.zone = user.time_zone
      
      if user.reminded == true
        user.update_attribute(:reminded, false)
        puts "Update to false"
        
      end
    end
  end
end