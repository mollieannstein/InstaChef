class Procedure < ActiveRecord::Base
  has_many :RecipeProcedures through: :recipes




end
