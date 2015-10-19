class SearchAlertDefaults < ActiveRecord::Migration
  def change
  	change_column_default :searches, :alert, false
  end
end
