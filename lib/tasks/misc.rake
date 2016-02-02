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
  desc "Remove subscription from test user"
  task :removesubscription => :environment do
    @user = User.find(1)
    @user.attributes = {
      :stripe_id => nil,
      :stripe_subscription_id => nil,
      :card_last4 => nil,
      :card_exp_month => nil,
      :card_exp_year => nil,
      :card_brand => nil
    }
    @user.save(:validate => false)
  end
end

namespace :misc do
  desc "Remove trial period (set created_at far back)"
  task :removetrial => :environment do
    @user = User.find(1)
    @user.update_attribute(:created_at, "2016-01-01 00:00:00")
  end
end

namespace :misc do
  desc "Invoke trial period (set created_at to today minus a few days)"
  task :invoketrial => :environment do
    @user = User.find(1)
    @user.update_attribute(:created_at, Time.now)
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

namespace :users do
  desc "Show all users"
  task :show => :environment do
    User.all.order(:id).each do |user|
      puts "#{user.id}: #{user.first_name} <#{user.email}>"
    end
  end
end

namespace :users do
  desc 'Deletes a given user. Usage: users:delete USER=42'
  task :delete => :environment do |t, args|
    user_id = ENV['USER'].to_i
    puts "Deleting user with id = #{user_id}"
 
    user = User.find(user_id)
    user.destroy
  end
end

namespace :misc do
  desc "Remove trial period (set created_at far back)"
  task :reset_streaks => :environment do
    User.all.each do |user|
      user.update_attribute(:streak_start, Time.now)
      user.update_attribute(:streak_end, Time.now)
    end
  end
end