class MealPlansController < ApplicationController
    before_action :set_menus, only: [:index, :create]
  
    # GET /meal_plans
    def index
      @dates = MealPlan.select(:date).distinct.order(date: :desc)  # Get all unique dates
      @meal_plans_by_date = MealPlan.all.group_by(&:date)  # Group meal plans by date
      @days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
      @meal_types = ["Breakfast", "Lunch", "Dinner"]
    end

    def edit
      @date = Date.parse(params[:date]) rescue Date.today
      meal_plans = MealPlan.all.group_by { |mp| [mp.day, mp.meal_type] }
      @meal_plans = meal_plans.transform_values(&:first)
      @days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
      @meal_types = ["Breakfast", "Lunch", "Dinner"]
      @menus = Menu.all
    end
  
    # POST /meal_plans
    def create
      date = params[:date] || Date.today
      params[:meal_plans].each do |day, meals|
        meals.each do |meal_type, menu_id|
          MealPlan.create(day: day, meal_type: meal_type, menu_id: menu_id, date: Date.today)
        end
      end
      flash[:meal_plan_saved] = true
      redirect_to meal_plans_path, notice: 'Meal plan was successfully updated.'
    end
  
    private
  
    def set_menus
      @menus = Menu.all
    end
  
    def meal_plans_params
      params.require(:meal_plans).permit(
        Monday: %i[Breakfast Lunch Dinner],
        Tuesday: %i[Breakfast Lunch Dinner],
        Wednesday: %i[Breakfast Lunch Dinner],
        Thursday: %i[Breakfast Lunch Dinner],
        Friday: %i[Breakfast Lunch Dinner],
        Saturday: %i[Breakfast Lunch Dinner],
        Sunday: %i[Breakfast Lunch Dinner]
      )
    end
  end
  