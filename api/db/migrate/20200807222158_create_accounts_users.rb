class CreateAccountsUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts_users do |t|
      t.timestamps null: false
    end
  end
end
