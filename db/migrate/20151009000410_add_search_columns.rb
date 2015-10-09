class AddSearchColumns < ActiveRecord::Migration
  def change
  	add_column :searches, :groupings, :text
  	add_column :searches, :combinator, :string
  end
end
