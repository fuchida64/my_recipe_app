class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id

    if @recipe.save
      flash[:create] = "recipe create success"
      redirect_to recipes_path
    else
      flash[:fail] = "recipe create fail"
      render 'new'
    end
  end

  private
    def recipe_params
      params.require(:recipe).permit(:title)
    end
end
