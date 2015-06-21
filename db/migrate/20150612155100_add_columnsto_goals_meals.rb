class AddColumnstoGoalsMeals < ActiveRecord::Migration
  def change
  	add_column :meals, :comments, :string
  	add_column :goals, :use_custom_goal, :boolean
  end
end
