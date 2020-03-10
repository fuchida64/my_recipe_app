class Ingredient < ApplicationRecord

  has_many :users, through: :user_ingredients
  has_many :user_ingredients, dependent: :destroy

  has_many :recipes, through: :recipe_ingredients
  has_many :recipe_ingredients, dependent: :destroy

  def self.ingredient_id(ingredient)
    ingredient_id = 0
    if existing_ingredient = Ingredient.find_by(name: ingredient.name)
      ingredient_id = existing_ingredient.id

    elsif ingredient.save
      ingredient_id = ingredient.id
    end

    ingredient_id
  end

end
