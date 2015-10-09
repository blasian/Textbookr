class RenameSearchesTable < ActiveRecord::Migration
  def change
  	remove_column :searches, :au_fname
  	remove_column :searches, :department

  	rename_column :searches, :au_lname, :author
  	rename_column :searches, :course_number, :course
  	add_foreign_key :searches, :user_accounts
  end
end