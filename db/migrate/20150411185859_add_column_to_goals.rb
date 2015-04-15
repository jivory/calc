class AddColumnToGoals < ActiveRecord::Migration
  def change
  	add_column :goals, :goal_type, :string
  end
end
