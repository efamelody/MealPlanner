class AddWeekStartDateToMealPlans < ActiveRecord::Migration[7.2]
  def change
    add_column :meal_plans, :week_start_date, :date
  end
end
