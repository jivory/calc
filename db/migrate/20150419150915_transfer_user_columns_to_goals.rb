class TransferUserColumnsToGoals < ActiveRecord::Migration
  def change
  	add_column :goals, :age, :integer
  	add_column :goals, :weight, :integer
  	add_column :goals, :height, :integer
  	add_column :goals, :activity, :string
  	add_column :goals, :sex, :string
  	remove_column :users, :age, :integer
		remove_column :users, :weight, :integer
  	remove_column :users, :height, :integer
  	remove_column :users, :activity, :string
  	remove_column :users, :sex, :string
  end
end
