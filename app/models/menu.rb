class Menu < ApplicationRecord
    # Relationships
    has_many :meal_plans, dependent: :destroy
  
    # Validations
    validates :name, presence: true, uniqueness: true
    validates :ingredients, presence: true
  
    # Helper method to convert ingredients string to an array
    def ingredient_list
      ingredients.split(',').map(&:strip)
    end
end
  