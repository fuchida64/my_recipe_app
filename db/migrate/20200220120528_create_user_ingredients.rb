class CreateUserIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :user_ingredients, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
      t.string :quantity
      t.integer :gram
      t.date :expiration_date
      t.integer :user_id
      t.integer :ingredient_id

      t.timestamps
    end
  end
end
