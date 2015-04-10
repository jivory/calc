class WelcomeController < ApplicationController
include ApplicationHelper

  def home
  	redirect_to meals_path if logged_in_user?
  end

  def help
  end

  def show
  end
end