class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
	before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :update_recipe_access, if: :date_has_changed?

  @@recipe_access_updated_at = Date.new(2020,1,1)

	protected

  	def configure_permitted_parameters
  		devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  	end

  private

    def date_has_changed?
      if @@recipe_access_updated_at
        Date.current > @@recipe_access_updated_at
      else
        true
      end
    end

    # 日付が変わったら、レシピアクセス数を更新
    def update_recipe_access
      Recipe.update_all_recipe_access
      @@recipe_access_updated_at = Date.current
    end
end
