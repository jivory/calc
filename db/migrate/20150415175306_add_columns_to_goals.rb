class AddColumnsToGoals < ActiveRecord::Migration
  def change
  	add_column :goals, :bmr_calories, :integer
  	add_column :goals, :custom_calories, :integer 
  end
end
