class AddColumnsToGoasl < ActiveRecord::Migration
  def change
  	add_column :goals, :user_id, :integer
  	add_column :goals, :daily_calories, :integer
  	add_column :goals, :desired_weight, :integer
  end
end
