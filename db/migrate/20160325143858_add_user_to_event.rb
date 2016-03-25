class AddUserToEvent < ActiveRecord::Migration
  def change
    add_column :events, :creator_id, :integer
    add_foreign_key :events, :users, column: :creator_id, name: :event_creator
    add_index :events, :creator_id
  end
end
