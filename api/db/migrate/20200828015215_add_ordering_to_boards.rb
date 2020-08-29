class AddOrderingToBoards < ActiveRecord::Migration[6.0]
  def change
    add_column :projects_board_items, :column_order, :integer
    add_column :projects_board_columns, :order, :integer
  end
end
