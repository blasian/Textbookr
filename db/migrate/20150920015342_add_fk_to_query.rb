class AddFkToQuery < ActiveRecord::Migration
  def change
  	rename_column :queries, :user_id, :user_account_id
  	add_foreign_key :queries, :user_accounts
  end
end
