module ApplicationHelper
	def logged_in_user?
		current_user != nil
	end

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

  def meal_time_calories(start, finish, meal_time)
    @today_meals = current_user.meals.where("? < day_of_meal 
                                            AND day_of_meal <= ?
                                            AND meal_time = ? ", 
                                            start.strftime('%Y-%m-%d'), 
                                            finish.strftime('%Y-%m-%d'), meal_time)
    @today_calorie_count = 0
    @today_meals.each do |meal|
      @today_calorie_count += meal.calories
    end
    return @today_calorie_count
  end

  def full_title(page_title = '')
    base_title = "Calci"
      if page_title.empty?
        base_title
      else
        "#{page_title} | #{base_title}"
      end
  end

end


#http://www.siteinspire.com/websites/2790-desktime
#http://www.siteinspire.com/websites/4055-sitedrop
#https://www.dropbox.com/guide/
#http://nikemakers.com/
#http://www.spelltower.com/#about
#http://nizoapp.com/