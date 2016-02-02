class AddStreakToUsers < ActiveRecord::Migration
  def change
    add_column :users, :streak, :integer
  end
end
