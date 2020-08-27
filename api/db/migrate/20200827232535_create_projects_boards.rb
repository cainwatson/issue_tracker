class CreateProjectsBoards < ActiveRecord::Migration[6.0]
  def change
    create_table :projects_boards do |t|
      t.string :name, null: false

      t.references :user_creator, null: false, foreign_key: { to_table: 'accounts_users' }
      t.references :project, null: false, foreign_key: { to_table: 'projects_projects' }

      t.timestamps null: false

      t.index %i[name project_id], unique: true
    end
  end
end
