class CreateProjectsBoardColumns < ActiveRecord::Migration[6.0]
  def change
    create_table :projects_board_columns do |t|
      t.string :name, null: false

      t.references :user_creator, null: false, foreign_key: { to_table: 'accounts_users' }
      t.references :board, null: false, foreign_key: { to_table: 'projects_boards' }

      t.timestamps null: false

      t.index %i[name board_id], unique: true
    end
  end
end
