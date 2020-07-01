class CreateRecipeIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :recipe_ingredients do |t|
      t.references :recipe, null: false
      t.references :ingredient, null: false
      t.integer :count, null: false, default: 0
      t.timestamps
    end
  end
end
