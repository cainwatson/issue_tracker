class CreateProjectsProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects_projects do |t|
      t.string :name, null: false
      t.string :photo_url, null: true
      t.boolean :is_private, null: false, default: false

      t.references :user_creator, null: false, foreign_key: { to_table: 'users' }
      t.references :organization, null: false, foreign_key: true

      t.timestamps null: false

      t.index [:name, :organization_id], unique: true
    end
  end
end
