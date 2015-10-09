class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :title_query
      t.float :price_min
      t.float :price_max
      t.string :author_query
      t.string :course_query
      t.integer :user_account_id

      t.timestamps null: false
    end
  end
end
