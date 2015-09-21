class RenameQuery < ActiveRecord::Migration
  def change
  	rename_table :queries, :user_queries
  end
end
