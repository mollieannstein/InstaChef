class Recipe < ActiveRecord::Base
  has_many :recipe_procedures
  has_many :procedures, through: :recipe_procedures
  has_many :ingredients
  has_many :directions
end
