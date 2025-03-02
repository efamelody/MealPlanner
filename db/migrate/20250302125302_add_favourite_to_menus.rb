class AddFavouriteToMenus < ActiveRecord::Migration[7.2]
  def change
    add_column :menus, :favourite, :boolean
  end
end
