class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find_by(name: params[:id])
    @recipes = @category.recipes if @category
  end
end
