class UsersController < ApplicationController
include GoalsHelper
#delete this whole thing

	def updates
		@user = User.find(params[:id])
		@goal = Goal.find(params[:id])
		if @user.update_attributes(user_params) && extra_validations
			@goal.update_attributes(goal_params)
			redirect_to goal_path
		else 
			flash[:danger] = @extra_error
			flash[:error] = @goal.errors.full_messages.to_sentence
			redirect_to new_goal_path
		end
	end

	private
	  def user_params
	  	params.require(:user).permit(:age, :weight, :sex, :activity, :height, goals_attributes: [ :id, :goal_name ])
	  end

	  def goal_params
	  	@weight_goal = params[:goal][:desired_weight].to_i
			@goal_type = define_goal(@weight_goal)
	  	@goal_params = { goal_type: @goal_type, 
											 bmr_calories: bmr_calculate, 
											 daily_calories: bmr_calculate }
		end

		def extra_validations
			if empty_error(params[:user][:age], :age) ||
				empty_error(params[:user][:sex], :sex) ||
				empty_error(params[:user][:weight], :weight) ||
				empty_error(params[:user][:height], :height) ||
				empty_error(params[:user][:activity], :activity) 
				return false
			else
				return true			
			end
		end

		def empty_error(attribute, name)
			@extra_error = "#{name.capitalize} cannot be blank.  "
			attribute.blank?
			#show multiple errors instead of one at a time. 
		end


end
