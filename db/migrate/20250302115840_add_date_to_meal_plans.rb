class AddDateToMealPlans < ActiveRecord::Migration[7.2]
  def change
    add_column :meal_plans, :date, :date
  end
end
