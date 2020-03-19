class Category < ApplicationRecord

  has_many :recipes

  def self.category_id(category)
    category_id = 0
    if existing_category = Category.find_by(name: category.name)
      category_id = existing_category.id

    elsif category.save
      category_id = category.id
    end
    category_id
  end

end
