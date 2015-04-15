class AddGoalNamew < ActiveRecord::Migration
  def change
  	add_column :goals, :goal_name, :string
  end
end
