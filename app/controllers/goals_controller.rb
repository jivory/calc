class GoalsController < ApplicationController
#include GoalsHelper

	def show
		@goal = Goal.find_by(id: params[:id])
		@user = current_user
		@gain_lose = (@user.weight - @goal.desired_weight).abs
	end

	def new
		@user = current_user
		@goal = @user.goals.build
	end

	def edit
		@user = current_user
		@goal = Goal.find_by(id: params[:id])
	end

	def index
		@goals = Goals.where(" user_id = ? ", params[:user_id])
	end

end

#    if kg_or_lb == "lb"
 # 		weight *= .453592
  #	end

 # 	if inches_or_cent == "inches"
 # 		height *= 2.54
 # 	end