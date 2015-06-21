class MealsController < ApplicationController
include MealsHelper

before_action :logged_in_user?, only: [:show]
before_action :set_meal, only: [:show]
before_action :correct_user, only: [:show]

  def show
    @meal = Meal.find_by(id: params[:id])
    #will show a single meal and prompt for the edit
  end

  def index
  #need to set this in the database for each user
  	Time.zone = "Eastern Time (US & Canada)" 
  	@last_month_meals = current_user.meals.where(" day_of_meal > ? ", 1.month.ago)
    @current_goal = current_user.goals.find_by(" current_goal = ? ", true)
  #splits out @last_month_meals by type
  	@meals_meals = []
  	@meals_snacks = []
  	@meals_drinks = []
    @meals_desserts = []
  	@count = 0
  	@last_month_meals.each do |meal|
  		if meal.meal_type == "meal"
  			@meals_meals << meal
  		elsif meal.meal_type == "drink"
  			@meals_drinks << meal
  		elsif meal.meal_type == "snack"
  			@meals_snacks << meal
      elsif meal.meal_type == "dessert"  
        @meal_desserts << meal
  		end
  	end

  #sets the week for the index view loop
  	@week = []
  	@day = Time.zone.now
  	while @day>7.day.ago do
  		@week << @day
  		@day -= 1.day
  	end

   	@meal_times = ["breakfast", "lunch", "dinner", "other"]
  	
  	@today = Time.zone.now.strftime('%Y-%m-%d')
  	@yesterday = 1.day.ago.strftime('%Y-%m-%d')

  #change week to month? and then limit view
  end

  def new
  	@meal = Meal.new
    @meal_type = { Meal: "meal", Drink: "drink", Snack: "snack", Drink: "drink", Dessert: "dessert" }
    @meal_time = { Breakfast: "breakfast", Lunch: "lunch", Dinner: "dinner", Other: "other" }
  end

  def create
  	@meal = current_user.meals.build(meal_params)
  	if @meal.save
  		redirect_to meals_path
  	else
  		flash[:error] = @meal.errors.full_messages.to_sentence
  		redirect_to new_meal_path
  	end
  	#1. meals should be valid. 2. if enter valid meal, send to index
  end

  def edit
  	@meal = Meal.find(params[:id])
  	@redirect = params[:data]
    @meal_type = { Meal: "meal", Drink: "drink", Snack: "snack", Drink: "drink", Dessert: "dessert" }
    @meal_time = { Breakfast: "breakfast", Lunch: "lunch", Dinner: "dinner", Other: "other" }
  end

  def update
  	@meal = Meal.find(params[:id])
  	@meal.update_attributes(meal_params)
  	@redirect = params[:redirect]
  	if @redirect == "show" 
  	  redirect_to meal_path(@meal)
  	else 
  	  redirect_to meals_path
  	end
  	   #want to redirect back to show page if came from there  #want to redirect back to index page if came from there

  	#1. updated meal should be valid. 2. if enter valid meal, send to index
  end

  def destroy
    
  	@meal = Meal.find(params[:id])
  	@meal.destroy
  	redirect_to meals_path
  end


private

  def set_meal
  	@meal = Meal.find_by(id: params[:id])
  end
  
  def meal_params
  	params.require(:meal).permit!
  end

  def correct_user
  	redirect_to root_path unless @meal.user_id == current_user.id
  end

  def logged_in_user?
  	redirect_to root_path unless current_user != nil 
  end

end
