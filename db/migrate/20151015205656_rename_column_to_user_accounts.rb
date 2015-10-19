class RenameColumnToUserAccounts < ActiveRecord::Migration
  def change
  	change_column_default :user_accounts, :email, ""
  end
end
