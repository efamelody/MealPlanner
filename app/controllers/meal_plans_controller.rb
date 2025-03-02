class MealPlansController < ApplicationController
    before_action :set_menus, only: [:index, :create]
  
    # GET /meal_plans
    def index
      # Get the week_start_date from params or default to this week's Monday
      @week_start_date = params[:week].present? ? Date.parse(params[:week]) : Date.today.beginning_of_week(:monday)
    
      # Fetch meal plans for the selected week
      @meal_plans = MealPlan.where(week_start_date: @week_start_date).index_by { |mp| [mp.day, mp.meal_type] }
    
      # Define week navigation links
      @previous_week = @week_start_date - 7.days
      @next_week = @week_start_date + 7.days
    
      @days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
      @meal_types = ["Breakfast", "Lunch", "Dinner"]
    end

    def edit
      @week_start_date = params[:week].present? ? Date.parse(params[:week]) : Date.today.beginning_of_week(:monday)
    
      # Fetch meal plans for the selected week
      @meal_plans = MealPlan.where(week_start_date: @week_start_date).index_by { |mp| [mp.day, mp.meal_type] }
    
      @days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
      @meal_types = ["Breakfast", "Lunch", "Dinner"]
      @menus = Menu.all
    end
    
  
    # POST /meal_plans
    def create
      week_start_date = params[:week_start_date].present? ? Date.parse(params[:week_start_date]) : Date.today.beginning_of_week(:monday)

      params[:meal_plans].each do |day, meals|
        meals.each do |meal_type, menu_id|
          meal_plan = MealPlan.find_or_initialize_by(day: day, meal_type: meal_type, week_start_date: week_start_date)
          meal_plan.menu_id = menu_id
          meal_plan.save
        end
      end

      redirect_to meal_plans_path(week: week_start_date.to_s), notice: 'Meal Plan Saved!'
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
  