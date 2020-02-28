class IngredientsController < ApplicationController
    before_action :authenticate_user!

  def index
    @ingredient = Ingredient.new
    @user_ingredient = UserIngredient.new
    @user_ingredients = UserIngredient.where(user_id: current_user.id)
    @ingredients = Ingredient.all
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    @user_ingredient = UserIngredient.new(user_ingredient_params)
    @user_ingredient.user_id = current_user.id

    if @existing_ingredient = Ingredient.find_by(name: ingredient_params[:name])
      flash[:existing_ingredient] = "#{ingredient_params[:name]}は存在します"
      @user_ingredient.ingredient_id = @existing_ingredient.id

    elsif @ingredient.save
      flash[:ingredient_success] = "ingredient成功"
      @user_ingredient.ingredient_id = @ingredient.id

    else
      flash[:fail] = "ingredient失敗"
      render 'index'
    end

    if @user_ingredient.save
      flash[:user_ingredient_success] = "user_ingredient成功"
      redirect_to ingredients_path

    else
      flash[:fail] = "user_ingredient失敗"
      render 'index'
    end
  end

  private

    def ingredient_params
      params.require(:ingredient).permit(:name)
    end

    def user_ingredient_params
      params.require(:user_ingredient).permit(:quantity, :gram, :expiration_date)
    end
end
