class Recipe < ActiveRecord::Base
  searchkick autocomplete: [:name]

  has_many :recipe_procedures
  has_many :procedures, through: :recipe_procedures, source: :procedure
  has_many :ingredients
  has_many :directions
end
