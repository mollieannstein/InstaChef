class Recipe < ActiveRecord::Base
  has_many :recipeprocedures
  has_many :procedures through: :recipeprocedures
end
