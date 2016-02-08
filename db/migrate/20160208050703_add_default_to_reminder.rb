class AddDefaultToReminder < ActiveRecord::Migration
  def change
    change_column :users, :reminder_time, :string, :default => '06:00 PM'
  end
end