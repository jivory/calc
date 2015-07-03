class GoalsController < ApplicationController
include GoalsHelper

	def show
		@user = current_user
		@goal = Goal.find(params[:id])
		@goal_attributes =  [["Goal Type", @goal.goal_type == nil ? @goal.goal_type : @goal.goal_type.capitalize ],
												 ["Current Weight", @goal.weight],
												 ["Desired Weight", @goal.desired_weight],
												 ["BMR Calculated Calories", hyphenate(@goal.bmr_calories)],
												 ["Custom Calories", hyphenate(@goal.custom_calories)],												 
												 ["Active Goal", @goal.current_goal]]

		@current_goal = current_user.goals.find_by(" current_goal = ? ", true)
		@calories = 0
		@calories_in_pound = 3500
		
		#pulling in month of dates
		@month = []
  	@day = Time.zone.now
  	while @day>1.month.ago do
  		@month << @day
  		@day -= 1.day
  	end

  	#query for one month's meals
  	@last_month_meals = current_user.meals.where(" ? >= day_of_meal AND day_of_meal >= ? ", 
  																								Time.zone.now.strftime('%Y-%m-%d'),
  																								1.month.ago.strftime('%Y-%m-%d'))

	end

	def index
		@goals = Goal.where(" user_id = ? ", current_user.id).order(current_goal: :desc).order(updated_at: :desc)
		@goal_attributes = [["Last Updated", "updated_at"],
												["Goal Type", "goal_type"],
												["Current Weight", "weight"],
												["Desired Weight", "desired_weight"],
												["BMR Calculated Calories", "bmr_calories"],
												["Custom Calories", "custom_calories"],												 
												["Active Goal", "current_goal"]]
		@goal_test = []
		@goals.each do |goal|			
			@test  = [["Last Updated", goal.updated_at],
								["Goal Type", goal.goal_type],
								["Current Weight", goal.weight],
								["Desired Weight", goal.desired_weight],
								["BMR Calculated Calories", goal.bmr_calories],
								["Custom Calories", goal.custom_calories],												 
								["Active Goal", goal.current_goal]]
			@goal_test << @test
			end
	end

	def new
		@user = current_user
		@goal = Goal.new
		@activity = { Sedentary: "sedentary", Mild: "mild", Moderate: "moderate", Heavy: "heavy", Extreme: "extreme" }
		@sex = { Male: "male", Female: "female" }
	end

	def create
		@goal = current_user.goals.create_with(current_goal: true).build(goal_params)
		if @goal.save
			if @goal.use_custom_goal == true
				@goal.update_attribute(:daily_calories, @goal.custom_calories)
				set_current_goal(@goal)
				redirect_to goal_path(@goal)
			else
				@goal_type = define_goal(@goal.desired_weight, @goal.weight) 
				@goal.update_attribute(:goal_type, @goal_type)
				@goal.update_attribute(:bmr_calories, bmr_calculate)
				@goal.update_attribute(:daily_calories, bmr_calculate)
				set_current_goal(@goal)
				redirect_to goal_path(@goal)
			end
		else
			flash[:error] = @goal.errors.full_messages.to_sentence
			redirect_to new_goal_path
		end
	end
  
  def custom
  	@goal = Goal.find_by(current_goal: true)
  end

  def destroy
  	@goal = Goal.find(params[:id])
  	@goal.destroy
  	redirect_to goals_path
  end

	def edit
		@user = current_user
		@goal = Goal.find(params[:id])
		@activity = { Sedentary: "sedentary", Mild: "mild", Moderate: "moderate", Heavy: "heavy", Extreme: "extreme" }
		@sex = { Male: "male", Female: "female" }
	end

	def update
		@goal = Goal.find_by(id: params[:id])
		if @goal.update_attributes(goal_params)
			if @goal.use_custom_goal == true
				@goal.update_attribute(:daily_calories, @goal.custom_calories)
				set_current_goal(@goal)
				redirect_to goal_path(@goal)
			else
				@goal_type = define_goal(@goal.desired_weight, @goal.weight) 
				@goal.update_attribute(:goal_type, @goal_type)
				@goal.update_attribute(:bmr_calories, bmr_calculate)
				@goal.update_attribute(:daily_calories, bmr_calculate)
				set_current_goal(@goal)
				redirect_to goal_path(@goal)
			end
		else
			flash[:error] = @goal.errors.full_messages.to_sentence
			redirect_to edit_goal_path
		end
	end

	def more_info
	end

	def set_custom_as_goal
		@goal = Goal.find(params[:format])
    set_current_goal(@goal)
    @goal.update_attribute(:daily_calories, @goal.custom_calories)
    @goal.update_attribute(:use_custom_goal, true)
    redirect_to goal_path(@goal)
  end

  def set_bmr_as_goal
  	@goal = Goal.find(params[:format])
    set_current_goal(@goal)
    @goal.update_attribute(:daily_calories, @goal.bmr_calories)
    @goal.update_attribute(:use_custom_goal, false)
    redirect_to goal_path(@goal)
  end


	private

	  def goal_params
	  	params.require(:goal).permit(:goal_name, :desired_weight, :age, :sex, :weight, :height, :activity, :goal_type, :bmr_calories, :daily_calories, :current_goal, :custom_calories, :use_custom_goal, :comments)
	  end

	 # def custom_params
	  #	params.require(:goal).permit(:goal_name, :custom_calories)
	  #end

#	  def empty_error(attribute, name)
#			@extra_error = "#{name.capitalize} cannot be blank"
#			attribute.blank?
#			#show multiple errors instead of one at a time. 
#		end
#		def negative_error(attribute, name)
#			@extra_error = "#{name.capitalize} must be greater than zero"
#			attribue > 0
#		end

#daily calories, goal_typ, bmr_calories, 

end

#    if kg_or_lb == "lb"
 # 		weight *= .453592
  #	end

 # 	if inches_or_cent == "inches"
 # 		height *= 2.54
 # 	end