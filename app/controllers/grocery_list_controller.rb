class GroceryListsController < ApplicationController
    def index
      @ingredients = MealPlan.joins(:menu).pluck(:ingredients).flatten.uniq
      @checked_ingredients = params[:checked] || []
      @grocery_list = @ingredients - @checked_ingredients
    end
end
  