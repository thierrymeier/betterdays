namespace :mail do
  desc "Send reminder if a user hasn't journaled in three days"
  
  task :reminder => :environment do
    User.all.each do |user|
      if !user.entries.empty? && user.entries.last.created_at < 3.days.ago
        UserMailer.reminder(user).deliver_now
      end
    end
  end
end