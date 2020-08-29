class CreateProjectsBoardColumnItem < ActiveRecord::Migration[6.0]
  def change
    create_table :projects_board_column_items do |t|
      t.references :user_creator, null: false, foreign_key: { to_table: 'accounts_users' }
      t.references :board_column, null: false, foreign_key: { to_table: 'projects_board_columns' }
      t.references :issue, null: true, foreign_key: { to_table: 'projects_issues' }

      t.timestamps null: false
    end
  end
end
