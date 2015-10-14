class AddCourseNumberToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :course_number, :integer
    rename_column :searches, :course, :department
  end
end
