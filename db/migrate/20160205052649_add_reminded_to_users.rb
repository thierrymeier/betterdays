class AddRemindedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :reminded, :boolean
  end
end
