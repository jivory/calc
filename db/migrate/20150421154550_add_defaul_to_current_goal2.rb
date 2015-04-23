class AddDefaulToCurrentGoal2 < ActiveRecord::Migration
  def change
  	change_column :goals, :current_goal, :boolean, :default => true
  end
end
