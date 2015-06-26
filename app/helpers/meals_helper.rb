module MealsHelper

  def over_under(calories, goal)
    if calories < goal
      return "under #{goal-calories}"
    elsif calories > goal
      return "over #{calories-goal}"
    else
      return nil
    end
  end

  def how_much_left(calories, goal)
    @number = (goal-calories).abs
    @comma_number = number_with_delimiter(@number, :delimiter => ",")
    if calories < goal 
      return "(#{@comma_number} left)"
    elsif calories > goal
      return "(#{@comma_number} over)"
    else
      return nil
    end
  end
  
end

#  def sum_meal_types(type, date, time) 
#    @same_meals = current_user.meals.where(" meal_type = ? 
#                                           AND day_of_meal = ? 
#                                             AND meal_time = ? ", 
#                                             type, date.strftime('%Y-%m-%d'), time)
#    @sum_meals = 0
#    @sum_calories = 0
#    @same_meals.each do |meal|
#      @sum_meals += 1
#      @sum_calories += meal.calories
#    end
#    return @sum_meals
#  end
