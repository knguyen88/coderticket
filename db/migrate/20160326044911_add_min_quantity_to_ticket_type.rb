class AddMinQuantityToTicketType < ActiveRecord::Migration
  def change
    add_column :ticket_types, :min_quantity, :integer, default: 1
  end
end
