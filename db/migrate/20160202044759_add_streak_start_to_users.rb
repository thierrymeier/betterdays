class AddStreakStartToUsers < ActiveRecord::Migration
  def change
    add_column :users, :streak_start, :datetime
  end
end
