class RecipeIngredient < ApplicationRecord

  attr_accessor :name

  belongs_to :recipe
  belongs_to :ingredient

end
