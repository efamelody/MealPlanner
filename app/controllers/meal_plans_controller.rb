class MealPlansController < ApplicationController
    before_action :set_menus, only: [:index, :create]
  
    # GET /meal_plans
    def index
      @days = %w[Monday Tuesday Wednesday Thursday Friday Saturday Sunday]
      @meal_types = %w[Breakfast Lunch Dinner]
      @meal_plans = MealPlan.includes(:menu).all.group_by { |mp| [mp.day, mp.meal_type] }
    end
  
    # POST /meal_plans
    def create
      meal_plans_params.each do |day, meals|
        meals.each do |meal_type, menu_id|
          next if menu_id.blank?
  
          meal_plan = MealPlan.find_or_initialize_by(day: day, meal_type: meal_type)
          meal_plan.update(menu_id: menu_id)
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
  