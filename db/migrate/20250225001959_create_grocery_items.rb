class CreateGroceryItems < ActiveRecord::Migration[7.2]
  def change
    create_table :grocery_items do |t|
      t.string :name
      t.boolean :checked

      t.timestamps
    end
  end
end
