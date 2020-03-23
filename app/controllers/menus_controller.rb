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

    @same_menu = Menu.where(user_id: current_user.id).where(recipe_id: @menu.recipe_id)

    # 同じレシピが存在したら、人数を更新
    if @same_menu.length > 0
      menu = Menu.find(@same_menu[0][:id])
      menu.update_attribute(:servings_for, menu.servings_for + @menu.servings_for)

      flash[:success] = "menu update success"
      redirect_to menus_path

    elsif @menu.save
      flash[:success] = "#{@menu.recipe.title} add success"
      redirect_to menus_path

    else
      flash[:alert] = "menu add fail"
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    @menu = Menu.find(params[:id])
    if menu_params[:servings_for].to_i < 1
      if @menu.destroy
        flash[:success] = "#{@menu.recipe.title}を献立から削除しました"
      else
        flash[:alert] = "#{@menu.recipe.title}の献立からの削除に失敗しました"
      end

    elsif @menu.update(menu_params)
      flash[:success] = "#{@menu.recipe.title}の人数を更新しました"
    else
      flash[:alert] = "#{@menu.recipe.title}の人数の更新に失敗しました"
    end
    redirect_to menus_path
  end

  private

    def menu_params
      params.require(:menu).permit(:servings_for, :recipe_id)
    end

end
