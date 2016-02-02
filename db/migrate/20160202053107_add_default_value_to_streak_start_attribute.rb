class AddDefaultValueToStreakStartAttribute < ActiveRecord::Migration
  def change
    change_column :users, :streak_start, :datetime, :default => Time.now
  end
end
