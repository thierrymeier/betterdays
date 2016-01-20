class AddReminderCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :reminder_count, :integer
  end
end
