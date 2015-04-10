class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.string :meal_type
      t.string :meal_time
      t.integer :calories
      t.date :day_of_meal
      
      t.timestamps null: false
    end
  end
end
