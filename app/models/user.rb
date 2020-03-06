class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    has_many :user_ingredients, dependent: :destroy
    has_many :ingredients, through: :user_ingredients
    has_many :recipes, dependent: :destroy
    has_many :menus, dependent: :destroy

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    validates :name,  presence: true, length: { maximum: 10 },
                      uniqueness: { case_sensitive: false }

    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }
end
