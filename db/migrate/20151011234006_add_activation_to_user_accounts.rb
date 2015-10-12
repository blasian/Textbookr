class AddActivationToUserAccounts < ActiveRecord::Migration
  def change
    add_column :user_accounts, :activation_digest, :string
    add_column :user_accounts, :activated, :boolean, default: false
    add_column :user_accounts, :activated_at, :datetime
  end
end
