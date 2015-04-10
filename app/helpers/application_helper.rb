module ApplicationHelper
	def logged_in_user?
		current_user != nil
	end

end
