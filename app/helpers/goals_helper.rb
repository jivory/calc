module GoalsHelper

  def bmr_calculate  	

  	@base_bmr = 0.0
  	@bmr = 0.0

  	if current_user.activity == "sedentary"
  		activity = 1.2
  	elsif current_user.activity == "mild"
  		activity = 1.375
  	elsif current_user.activity == "moderate"
  		activity = 1.55
  	elsif current_user.activity == "heavy"
  		activity = 1.7
  	elsif current_user.activity == "extreme"
  		activity = 1.9
  	end

  	@weight = current_user.weight * 0.453592
  	@height = current_user.height * 2.54

  	if current_user.sex == "male"
  		@base_bmr = 66.47 + ( 13.75 * @weight ) + ( 5.003 * @height ) - ( 6.755 * current_user.age )
			@bmr = @base_bmr * activity
			@bmr.to_i
		elsif
  		@base_bmr = 655.1 + ( 9.563 * @weight ) + ( 1.850 * @height ) - ( 4.676 * current_user.age )
			@bmr = @base_bmr * activity
			@bmr.to_i
  	end
  end

  def define_goal(weight)

  	if current_user.weight > weight
  		return "lose"
  	elsif current_user.weight < weight
  		return "gain"
  	elsif current_user.weight == weight
  		return "maintain"
  	end
  end

end
