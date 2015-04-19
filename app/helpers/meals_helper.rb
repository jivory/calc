module MealsHelper

  def total_calories(start, finish)
  	@today_meals = current_user.meals.where("? < day_of_meal AND day_of_meal <= ?", 
                                            start.strftime('%Y-%m-%d'), 
                                            finish.strftime('%Y-%m-%d'))
  	@today_calorie_count = 0
  	@today_meals.each do |meal|
  	  @today_calorie_count += meal.calories
  	end
  	return @today_calorie_count
  end

  def sum_meal_types(type, date, time) 
  	@same_meals = current_user.meals.where(" meal_type = ? 
  																				   AND day_of_meal = ? 
  																				   AND meal_time = ? ", 
  																				   type, date.strftime('%Y-%m-%d'), time)
  	@sum_meals = 0
  	@sum_calories = 0
  	@same_meals.each do |meal|
  		@sum_meals += 1
  		@sum_calories += meal.calories
  	end
  	return @sum_meals
  end
  
end
