class HomeController < ApplicationController
  def index
    @daily_recipes = Recipe.all.order(daily_access: "DESC").limit(10)
    @weekly_recipes = Recipe.all.order(weekly_access: "DESC").limit(10)
    @monthly_recipes = Recipe.all.order(monthly_access: "DESC").limit(10)

    @categories = Category.all
  end
end