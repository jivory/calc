class Meal < ActiveRecord::Base
  belongs_to :user
  validates :meal_type, presence: true
  #validates :meal_time
  validates :calories,
  						presence: true,
  						numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10000 }					
  validates :day_of_meal, presence: true

end
