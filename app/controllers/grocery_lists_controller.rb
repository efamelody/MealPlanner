class GroceryListsController < ApplicationController

  # GET /grocery_lists
  def index
    # Fetch all selected menus from the meal plan
    selected_menu_ids = MealPlan.pluck(:menu_id)
    selected_menus = Menu.where(id: selected_menu_ids)

    # Extract and split ingredients into individual items
    ingredient_list = selected_menus.flat_map { |menu| menu.ingredients.split(',').map(&:strip) }

    # Add new ingredients to the grocery list if not already present
    ingredient_list.each do |ingredient|
      existing_item = GroceryItem.find_by(name: ingredient)
      unless existing_item
        GroceryItem.create(name: ingredient, checked: false)
      end
    end

    # Fetch all grocery items (checked and unchecked)
    @grocery_items = GroceryItem.all.order(:name)
  end

  # PATCH /grocery_lists
  def update
    # Update the checked status of grocery items based on user input
    checked_items = params[:grocery_items] || []

    GroceryItem.all.each do |item|
      item.update(checked: checked_items.include?(item.name))
    end
    flash[:grocery_list_updated] = true
    redirect_to grocery_lists_path, notice: 'Grocery list updated successfully.'
  end

  # GET /grocery_lists/view_list
  def view_list
    # Show only the unticked (unchecked) items
    @grocery_items = GroceryItem.where(checked: false).order(:name)
  end
end
