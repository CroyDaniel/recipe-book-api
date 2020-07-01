class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.references :game, null: false
      t.string :name, null: false
      t.index [:name, :game_id], unique: true
      t.timestamps
    end
  end
end
