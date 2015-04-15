class AddCaloriesInputsToUser < ActiveRecord::Migration
  def change
  	add_column :users, :age, :integer
  	add_column :users, :weight, :integer
  	add_column :users, :height, :integer
  	add_column :users, :activity, :string
  	add_column :users, :sex, :string
  end
end
