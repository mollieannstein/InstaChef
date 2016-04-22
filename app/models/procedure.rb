class Procedure < ActiveRecord::Base
  has_many :recipeprocedures
  has_many :recipes through: :recipeprocedures

end
