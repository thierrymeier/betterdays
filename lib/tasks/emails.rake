namespace :mail do
  desc "Send daily reminder to users"
  task :daily_reminder => :environment do
    User.with_reminder.find_each do |user|
      Time.zone = user.time_zone
      if Time.current.strftime("%I:00 %p") == user.reminder_time
        UserMailer.daily_reminder(user).deliver_now
        puts "Send email.. to #{user.email}"
      end
    end
  end
end