class ApplicationController < ActionController::Base
include ActionView::Helpers::NumberHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :layout_by_resources

  def layout_by_resources
  	if controller_name == "sessions" && action_name == "new"
  		"blank"
  	else
  		"application"
  	end
  end

  def hyphenate(number)
    number_with_delimiter(number, :delimiter => ",")
  end


end
