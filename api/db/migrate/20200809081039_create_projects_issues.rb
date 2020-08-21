class CreateProjectsIssues < ActiveRecord::Migration[6.0]
  def change
    create_table :projects_issues do |t|
      t.string :summary, null: false
      t.text :description, null: false, default: ''
      t.integer :number, null: false

      t.references :user_creator, null: false, foreign_key: { to_table: 'accounts_users' }
      t.references :project, null: false, foreign_key: { to_table: 'projects_projects' }

      t.timestamps null: false

      t.index %i[number project_id], unique: true
    end
  end
end
