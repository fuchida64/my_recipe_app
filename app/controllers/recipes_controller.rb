class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
    @category = Category.new
    recipe_procedures = @recipe.recipe_procedures.build
    recipe_ingredients = @recipe.recipe_ingredients.build
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id

    @category = Category.new(category_params)

    #カテゴリー存在チェック・作成
    if @existing_category = Category.find_by(name: category_params[:name])
      flash[:existing_category] = "#{category_params[:name]} exits"
      @recipe.category_id = @existing_category.id

    elsif @category.save
      flash[:category_success] = "category create success"
      @recipe.category_id = @category.id

    else
      flash[:fail] = "category create fail"
      render 'new'
    end

    #材料存在チェック・作成
    @recipe.recipe_ingredients.each do |ingredient|
      @ingredient = Ingredient.new(name: ingredient.name)
      if @existing_ingredient = Ingredient.find_by(name: ingredient.name)
        flash[:existing_ingredient] = "#{ingredient.name} exits"
        ingredient.ingredient_id = @existing_ingredient.id

      elsif @ingredient.save
        flash[:ingredient_success] = "ingredient create success"
        ingredient.ingredient_id = @ingredient.id

      else
        flash[:fail] = "ingredient create fail"
        render 'new'
      end
    end

    #レシピ作成
    if @recipe.save
      flash[:create] = "recipe create success"
      redirect_to recipes_path
    else
      flash[:fail] = "recipe create fail"
      render 'new'
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  private
    def recipe_params
      params.require(:recipe).permit(
        :title, :description, :cooking_time,
        recipe_procedures_attributes: [:id, :instruction, :_destroy],
        recipe_ingredients_attributes: [:id, :quantity, :ingredient_id, :_destroy, :name]
        )
    end

    def category_params
      params.require(:category).permit(:name)
    end
end
