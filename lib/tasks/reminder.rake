namespace :mail do
  desc "Send reminder if user hasn't journaled that day"
  
  task :daily_reminder => :environment do

    User.all.each do |user|
      if user.entries.last.created_at.strftime("%A, %d of %B %Y") < Time.now.strftime("%A, %d of %B %Y")
        UserMail.reminder(user).deliver
      end
    end
    
  end
end
