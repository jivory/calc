class GoalsController < ApplicationController
include GoalsHelper

	def show
		@user = current_user
		@goal = Goal.find(params[:id])
		@goal_attributes =  [["Goal Id", @goal.id],
												 ["Goal Name", @goal.goal_name],
												 ["Goal Type", @goal.goal_type.capitalize],
												 ["Current Weight", @goal.weight],
												 ["Desired Weight", @goal.desired_weight],
												 ["BMR Calculated Calories", @goal.bmr_calories],
												 ["Custom Calories", @goal.custom_calories],
												 ["Active Goal", @goal.current_goal],
												 ["Current Calorie Goal", @goal.daily_calories]]
		@current_goal = current_user.goals.find_by(" current_goal = ? ", true)
		@past_week_calories = 0
		
	end

	def index
		@goals = Goal.where(" user_id = ? ", current_user.id).order(current_goal: :desc).order(:updated_at)
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
			@goal_type = define_goal(@goal.desired_weight, @goal.weight) 
			@goal.update_attribute(:goal_type, @goal_type)
			@goal.update_attribute(:bmr_calories, bmr_calculate)
			@goal.update_attribute(:daily_calories, bmr_calculate)
			set_current_goal(@goal)
			@goal.update_attribute(:current_goal, true)
			redirect_to goal_path(@goal)
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
			@goal_type = define_goal(@goal.desired_weight, @goal.weight) 
			@goal.update_attribute(:goal_type, @goal_type)
			@goal.update_attribute(:bmr_calories, bmr_calculate)
			@goal.update_attribute(:daily_calories, bmr_calculate)
			set_current_goal(@goal)
			redirect_to goal_path
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
    redirect_to goal_path(@goal)
  end

  def set_bmr_as_goal
  	@goal = Goal.find(params[:format])
    set_current_goal(@goal)
    @goal.update_attribute(:daily_calories, @goal.bmr_calories)
    redirect_to goal_path(@goal)
  end


	private

	  def goal_params
	  	params.require(:goal).permit(:goal_name, :desired_weight, :age, :sex, :weight, :height, :activity, :goal_type, :bmr_calories, :daily_calories, :current_goal, :custom_calories)
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