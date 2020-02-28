class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :title
      t.string :image
      t.string :description
      t.integer :servings_for
      t.integer :cooking_time
      t.integer :daily_access
      t.integer :weekly_access
      t.integer :monthly_access
      t.integer :total_access
      t.integer :user_id
      t.integer :category_id

      t.timestamps
    end

    add_index :recipes, :title, unique: true
  end
end
