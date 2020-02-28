class Recipe < ApplicationRecord

  belongs_to :user
  belongs_to :category

  has_many :recipe_procedures, dependent: :destroy
  accepts_nested_attributes_for :recipe_procedures, allow_destroy: true

  has_many :recipe_ingredients, dependent: :destroy
  accepts_nested_attributes_for :recipe_ingredients, allow_destroy: true

  mount_uploader :image, ImageUploader

  # validation
  #title max 20

end
