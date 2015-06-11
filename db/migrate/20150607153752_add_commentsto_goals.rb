class AddCommentstoGoals < ActiveRecord::Migration
  def change
  	add_column :goals, :comments, :string
  end
end
