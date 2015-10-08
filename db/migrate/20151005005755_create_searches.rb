class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :title
      t.float :price_min
      t.float :price_max
      t.string :au_fname
      t.string :au_lname
      t.string :course_number
      t.string :department
      t.integer :user_account_id

      t.timestamps null: false
    end
  end
end
