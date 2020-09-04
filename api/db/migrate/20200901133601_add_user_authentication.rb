class AddUserAuthentication < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts_users, :email, :string, null: false, default: ''
    add_column :accounts_users, :password_digest, :string, null: false, default: ''
    add_column :accounts_users, :jti, :string, null: false, default: ''

    add_index :accounts_users, :email, unique: true
    add_index :accounts_users, :jti, unique: true
  end
end
