class MealPlan < ApplicationRecord
    # Relationships
    belongs_to :menu
  
    # Validations
    validates :day, presence: true, inclusion: { in: %w[Monday Tuesday Wednesday Thursday Friday Saturday Sunday] }
    validates :meal_type, presence: true, inclusion: { in: %w[Breakfast Lunch Dinner] }
    validates :menu_id, presence: true
end
  