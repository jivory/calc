class AddBdayandSextoUsers < ActiveRecord::Migration
  def change
  	add_column :users, :birth_date, :date
  	add_column :users, :sex, :binary
  end
end
