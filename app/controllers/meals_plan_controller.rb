class MealPlansController < ApplicationController
    def index
      @meal_plans = MealPlan.all.includes(:menu)
      @menus = Menu.all
      @days = %w[Monday Tuesday Wednesday Thursday Friday Saturday Sunday]
      @meal_types = %w[Breakfast Lunch Dinner]
    end
  
    def create
      @meal_plan = MealPlan.new(meal_plan_params)
      if @meal_plan.save
        redirect_to meal_plans_path, notice: 'Meal plan added successfully.'
      else
        render :index
      end
    end
  
    private
  
    def meal_plan_params
      params.require(:meal_plan).permit(:day, :meal_type, :menu_id)
    end
end
  