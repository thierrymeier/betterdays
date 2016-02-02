class AddDefaultValueToStreakEndAttribute < ActiveRecord::Migration
  def change
    change_column :users, :streak_end, :datetime, :default => Time.now
  end
end
