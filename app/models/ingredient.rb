class Ingredient < ApplicationRecord

  has_many :user_ingredients, dependent: :destroy
  has_many :users, through: :user_ingredients

end