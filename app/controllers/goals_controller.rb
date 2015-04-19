class GoalsController < ApplicationController
#include GoalsHelper

	def show
		@user = current_user
		@goal = @user.goals.first
		@gain_lose = (@user.weight - @goal.desired_weight).abs
	end

	def update
		@goal = Goal.find_by(id: params[:id])
		if @goal.update_attributes(goal_params)
			@goal.update_attribute(:daily_calories, @goal.custom_calories)
			redirect_to goal_path
		else
			flash[:error] = @goal.errors.full_messages.to_sentence
			redirect_to edit_goal_path
		end
	end


	def new
		@user = current_user
		@goal = @user.goals.build
		@activity = { Sedentary: "sedentary", Mild: "mild", Moderate: "moderate", Heavy: "heavy", Extreme: "extreme" }
	end

	def edit
		@user = current_user
		@goal = Goal.find_by(id: params[:id])
		@activity = { Sedentary: "sedentary", Mild: "mild", Moderate: "moderate", Heavy: "heavy", Extreme: "extreme" }
	end

	def index
		@goals = Goals.where(" user_id = ? ", params[:user_id])
	end

	def more_info
	end

	private

	  def goal_params
	  	params.require(:goal).permit(:daily_calories, :goal_name, :custom_calories)
	  end


end

#    if kg_or_lb == "lb"
 # 		weight *= .453592
  #	end

 # 	if inches_or_cent == "inches"
 # 		height *= 2.54
 # 	end