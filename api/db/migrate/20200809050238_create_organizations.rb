class CreateOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :organizations do |t|
      t.string :name, null: false, index: {unique: true}
      t.string :photo_url

      t.references :user_creator, null: false, foreign_key: { to_table: 'users' }

      t.timestamps null: false
    end
  end
end
