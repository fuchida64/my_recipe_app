class IngredientsController < ApplicationController

  def index
    @user_ingredient = UserIngredient.new
  end

  def create
    # ingredientが存在するかしないか
    # 存在しなかったら、ingredientを作成してからuser_ingredientを作成
  end
end
