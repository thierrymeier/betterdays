class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.text :content
      t.string :location
      t.integer :rating
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
