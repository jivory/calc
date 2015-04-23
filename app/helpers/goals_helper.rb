module GoalsHelper

  def set_current_goal
    @user_goals = Goal.where(" user_id = ? ", current_user.id)
    @user_goals.each do |goal|
      unless goal == @goal 
        goal.update_attribute(:current_goal, false)
      end
    end
    @goal.update_attribute(:current_goal, true)
  end
  
  def gain_lose
    if @goal.weight != nil && @goal.desired_weight != nil
      @gain_lose = (@goal.weight - @goal.desired_weight).abs
    end
  end

  def bmr_calculate  	

  	@base_bmr = 0.0
  	@bmr = 0.0

  	if @goal.activity == "sedentary"
  		activity = 1.2
  	elsif @goal.activity == "mild"
  		activity = 1.375
  	elsif @goal.activity == "moderate"
  		activity = 1.55
  	elsif @goal.activity == "heavy"
  		activity = 1.7
  	elsif @goal.activity == "extreme"
  		activity = 1.9
  	end

  	@weight = @goal.weight * 0.453592
  	@height = @goal.height * 2.54
  	@lose_gain_multiplier = { lose: 0.9, gain: 1.1, maintain: 1.0 }

  	if @goal.sex == "male"
  		@base_bmr = 66.47 + ( 13.75 * @weight ) + ( 5.003 * @height ) - ( 6.755 * @goal.age )
			@bmr = @base_bmr * activity 
			@lose_gain_bmr = @bmr * @lose_gain_multiplier[@goal_type]
			@lose_gain_bmr.to_i
		elsif
  		@base_bmr = 655.1 + ( 9.563 * @weight ) + ( 1.850 * @height ) - ( 4.676 * @goal.age )
			@bmr = @base_bmr * activity 
			@lose_gain_bmr = @bmr * @lose_gain_multiplier[@goal_type]
			@lose_gain_bmr.to_i
  	end
  end

  def define_goal(desired_weight, weight)

  	if weight > desired_weight
  		return :lose
  	elsif weight < desired_weight
  		return :gain
  	elsif weight == desired_weight
  		return :maintain
  	end
  end

end
