class Procedure < ActiveRecord::Base
  has_many :recipe_procedures
  has_many :recipes, through: :recipe_procedures
end
