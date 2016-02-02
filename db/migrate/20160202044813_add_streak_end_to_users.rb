class AddStreakEndToUsers < ActiveRecord::Migration
  def change
    add_column :users, :streak_end, :datetime
  end
end
