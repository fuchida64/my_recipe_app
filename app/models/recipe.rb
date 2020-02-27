class Recipe < ApplicationRecord

  belongs_to :user
  belongs_to :category
  has_many :recipe_procedures, dependent: :destroy

  accepts_nested_attributes_for :recipe_procedures, allow_destroy: true

end
