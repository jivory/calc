class UsersController < ApplicationController
include GoalsHelper

	def updates
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			@weight_goal = params[:goal][:desired_weight].to_i
			current_user.goals.update_all(goal_name: params[:goal][:goal_name])
			current_user.goals.update_all(desired_weight: params[:goal][:desired_weight])
			current_user.goals.update_all(daily_calories: bmr_calculate)
			current_user.goals.update_all(goal_type: define_goal(@weight_goal))
			redirect_to goal_path
		else 
			flash[:error] = @meal.errors.full_messages.to_sentence
			redirect_to new_goal_path
		end
	end

	private
	  def user_params
	  	params.require(:user).permit(:age, :weight, :sex, :activity, :height, goals_attributes: [ :id, :goal_name ])
	  end
end
