class AddColumnSearches < ActiveRecord::Migration
  def change
  	add_column :searches, :alert, :boolean
  	drop_table :user_queries
  end
end
