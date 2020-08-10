class CreateOrganizationsMemberships < ActiveRecord::Migration[6.0]
  def change
    create_table :organizations_memberships do |t|
      t.references :user_from, null: false, foreign_key: { to_table: 'accounts_users' }
      t.references :user_to, null: false, foreign_key: { to_table: 'accounts_users' }
      t.references :organization, null: false, foreign_key: { to_table: 'organizations_organizations' }

      t.timestamps null: false
    end
  end
end
