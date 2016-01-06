class AddReminderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :reminder, :boolean, default: true
  end
end
