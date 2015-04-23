class RemoveDefaultfromGoal < ActiveRecord::Migration
  def change
  	change_column :goals, :current_goal, :boolean
  end
end
