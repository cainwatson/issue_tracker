class CreateProfilesProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles_profiles do |t|
      t.string :first_name, null: false
      t.string :last_name
      t.string :photo_url

      t.references :user, null: false, foreign_key: { to_table: 'accounts_users' }

      t.timestamps null: false
    end
  end
end
