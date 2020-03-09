class Recipe < ApplicationRecord

  belongs_to :user
  belongs_to :category

  has_many :recipe_procedures, dependent: :destroy
  accepts_nested_attributes_for :recipe_procedures, allow_destroy: true

  has_many :recipe_ingredients, dependent: :destroy
  accepts_nested_attributes_for :recipe_ingredients, allow_destroy: true

  has_many :menus, dependent: :destroy

  mount_uploader :image, ImageUploader

  # validation
  #title max 20

  def self.add_recipe_access(recipe)
    recipe.update(daily_access: recipe.daily_access + 1,
                  weekly_access: recipe.weekly_access + 1,
                  monthly_access: recipe.monthly_access + 1,
                  total_access: recipe.total_access + 1
                  )
  end

  def self.update_all_recipe_access
    #日間アクセス数リセット
    Recipe.update_all("daily_access = 0")

    #週間アクセス数リセット
    Recipe.update_all("weekly_access = 0") if Date.current.monday?

    #月間リセット
    Recipe.update_all("monthly_access = 0") if Date.current.day == 1
  end

end
