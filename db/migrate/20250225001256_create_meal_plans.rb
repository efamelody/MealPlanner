class CreateMealPlans < ActiveRecord::Migration[7.2]
  def change
    create_table :meal_plans do |t|
      t.string :day
      t.string :meal_type
      t.references :menu, null: false, foreign_key: true

      t.timestamps
    end
  end
end
