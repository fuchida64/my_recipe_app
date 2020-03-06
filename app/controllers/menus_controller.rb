class MenusController < ApplicationController

  def index
    @menus = current_user.menus

    # 材料の絞り込み
    @ingredients = []
    puts @ingredients.class
    @menus.each do |menu|
      puts "★menu.id #{menu.id}"
      servings_for = menu.servings_for
      RecipeIngredient.where(recipe_id: menu.recipe_id).each do |ingredient|
        puts "ingredient #{ingredient}"
        @ingredients << {
          id: ingredient.ingredient_id,
          name: ingredient.ingredient.name,
          quantity: "#{ingredient.quantity} × #{servings_for}"
        }
      end
    end
    puts @ingredients
  end

  def create
    @menu = Menu.new(menu_params)
    @menu.user_id = current_user.id

    if @menu.save
      flash[:notice] = "#{@menu.recipe.title} add success"
      redirect_to menus_path
    else
      flash[:alert] = "menu add fail"
      redirect_back(fallback_location: root_path)
    end

  end

  private

    def menu_params
      params.require(:menu).permit(:servings_for, :recipe_id)
    end

end
