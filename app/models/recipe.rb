class Recipe < ActiveRecord::Base
  has_many :recipe_procedures
  has_many :procedures, through: :recipe_procedures
end
