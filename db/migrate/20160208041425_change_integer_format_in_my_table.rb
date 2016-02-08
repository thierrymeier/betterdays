class ChangeIntegerFormatInMyTable < ActiveRecord::Migration
  def change
    change_column :users, :reminder_time, :string
  end
end
