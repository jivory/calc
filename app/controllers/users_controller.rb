class UsersController < ApplicationController

def sign_up 
	@sex = { Male: 1, Female: 0 }
end


	private
	  def user_params
	  	params.require(:user).permit(:age, :weight, :sex, :activity, :height, goals_attributes: [ :id, :goal_name ])
	  end
end
