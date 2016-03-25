class CreateEventAdmins < ActiveRecord::Migration
  def change
    create_table :event_admins do |t|
      t.column :event_id, :integer
      t.column :admin_id, :integer
      t.timestamps null: false
    end

    add_foreign_key :event_admins, :events, column: :event_id
    add_index :event_admins, :event_id

    add_foreign_key :event_admins, :users, column: :admin_id, name: :event_admin
    add_index :event_admins, :admin_id
  end
end
