class AddReminderTimeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :reminder_time, :integer
  end
end
