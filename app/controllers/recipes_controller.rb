class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
  end

  def search
    @recipes = Recipe.search(params[:search])
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

    #カテゴリー存在チェック・作成
    @category = Category.new(category_params)
    @recipe.category_id = Category.category_id(@category)

    if @recipe.category_id == 0
      flash[:fail] = "category create fail"
      render 'new'
    end

    #材料存在チェック・作成
    @recipe.recipe_ingredients.each do |recipe_ingredient|
      @ingredient = Ingredient.new(name: recipe_ingredient.name)
      recipe_ingredient.ingredient_id = Ingredient.ingredient_id(@ingredient)

      if recipe_ingredient.ingredient_id == 0
        flash[:fail] = "ingredient create fail"
        render 'new'
      end
    end

    #レシピ作成
    if @recipe.save
      flash[:create] = "recipe create success"
      redirect_to recipe_path(@recipe)
    else
      flash[:fail] = "recipe create fail"
      render 'new'
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @menu = Menu.new
    Recipe.add_recipe_access(@recipe)
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @category = @recipe.category
    recipe_ingredients = @recipe.recipe_ingredients

    recipe_ingredients.each do |recipe_ingredient|
      recipe_ingredient.name = recipe_ingredient.ingredient.name
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    @category = @recipe.category

    #カテゴリー存在チェック・作成
    @new_category = Category.new(category_params)
    @recipe.category_id = Category.category_id(@new_category)

    if @recipe.category_id == 0
      flash[:fail] = "category create fail"
      render 'new'
    end

    #材料存在チェック・作成
    # 初期化
    modified_recipe_params = recipe_params
    modified_recipe_params[:recipe_ingredients_attributes].each do |i, ingredient|

      @ingredient = Ingredient.new(name: ingredient[:name])

      if @existing_ingredient = Ingredient.find_by(name: ingredient[:name])
        flash["existing_ingredient#{i}".to_sym] = "#{ingredient[:name]} exits"
        ingredient[:ingredient_id] = @existing_ingredient.id

      elsif @ingredient.save
        flash["ingredient_success#{i}".to_sym] = "#{ingredient[:name]} create success"
        ingredient[:ingredient_id] = @ingredient.id

      else
        flash[:fail] = "ingredient create fail"
        render 'new'
      end
    end

    if @recipe.update(modified_recipe_params)
      flash[:update] = "recipe update success"
      redirect_to recipe_path(@recipe)
    else
      flash[:fail] = "recipe update fail"
      render 'edit'
    end
  end

  private

    def recipe_params
      params.require(:recipe).permit(
        :title, :image, :description, :cooking_time, :servings_for,
        recipe_procedures_attributes: [:id, :instruction, :image, :_destroy],
        recipe_ingredients_attributes: [:id, :quantity, :gram, :ingredient_id, :_destroy, :name]
        )
    end

    def category_params
      params.require(:category).permit(:name)
    end
end
