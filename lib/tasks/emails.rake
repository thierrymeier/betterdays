namespace :mail do
  desc "Send reminder if a user hasn't journaled in three days"
  
  task :reminder => :environment do
    User.all.each do |user|
      if !user.entries.empty? && user.entries.first.created_at < 3.days.ago && user.reminder_count == 0
        UserMailer.reminder(user).deliver_now
        user.update_attribute(:reminder_count, 3)
      end
    end
  end
end