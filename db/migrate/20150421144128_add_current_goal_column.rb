class AddCurrentGoalColumn < ActiveRecord::Migration
  def change
  	add_column :goals, :current_goal, :boolean
  end
end
