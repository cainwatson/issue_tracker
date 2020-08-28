class AddRankToBoards < ActiveRecord::Migration[6.0]
  def change
    add_column :projects_board_columns, :rank, :integer
    add_column :projects_board_column_issues, :rank, :integer
  end
end