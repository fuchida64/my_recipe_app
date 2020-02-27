class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
    @category = Category.new
    recipe_procedures = @recipe.recipe_procedures.build
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

    #レシピ作成
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
      params.require(:recipe).permit(
        :title,
        recipe_procedures_attributes: [:id, :instruction, :_destroy]
        )
    end

    def category_params
      params.require(:category).permit(:name)
    end
end
